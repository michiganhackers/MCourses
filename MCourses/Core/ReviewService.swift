//
//  ReviewService.swift
//  MCourses
//
//  Created by Finn Moore on 4/13/24.
//

import Firebase

struct ReviewService {
    
    func uploadReview(review: Review) async throws {
        guard let uid = getCurrentUserID() else { return }
        
        let data: [String: Any] = [
            "uid": uid,
            "review": review,
            "votes": 0,
            "timestamp": Timestamp(date: Date()),
        ]
        
        // NOTE: This has all quotes in one collection... everything is global... no following!
        try await Firestore.firestore().collection("reviews").document().setData(data)
        return
    }
    
    func deleteReview(review: Review, complettion: @escaping (String?) -> Void) {
        guard let reviewID = review.id else { return }
        
        Firestore.firestore().collection("reviews").document(reviewID)
            .delete { _ in
                complettion(reviewID)
            }
    }
    
    func deleteDeletedReview(fromUsers users: [User], reviewID: String) {
        let usersCollection = Firestore.firestore().collection("users")
        
        for user in users {
            guard let userID = user.id else { continue }
            
            usersCollection.document(userID).collection("userUpvotes").document(reviewID).delete()
            usersCollection.document(userID).collection("userDownvotes").document(reviewID).delete()
        }
    }
}

// MARK: - Fetch Logic
extension ReviewService {
    func fetchReviews() async throws -> [Review] {
        let snapshot = try await Firestore.firestore().collection("reviews")
            .order(by: "votes", descending: true)
            .getDocuments()
        let documents = snapshot.documents
        let reviews = documents.compactMap {
            try? $0.data(as: Review.self)
        }
        return reviews
    }
    
}

// MARK: - UpVote Logic
extension ReviewService {
    func upvoteReview(_ review: Review, completion: @escaping (Int) -> Void) {
        guard let uid = getCurrentUserID() else { return }
        guard let reviewID = review.id else { return }
        
        let userUpvotesCollectionRef = Firestore.firestore().collection("users").document(uid).collection("userUpvotes")
        
        Firestore.firestore().collection("reviews").document(reviewID)
            .updateData(["votes": review.votes + 1]) { error in
                if let error {
                    print("DEBUG: Failed to update review upvotes, \(error)")
                    return
                }
                
                userUpvotesCollectionRef.document(reviewID).setData([:]) { _ in
                    completion(review.votes + 1)
                }
            }
    }
    
    func unUpvoteReview(_ review: Review, completion: @escaping (Int) -> Void) {
        guard let uid = getCurrentUserID() else { return }
        guard let reviewID = review.id else { return }
        guard review.votes > 0 else { return }
        
        let userUpvotesCollectionRef = Firestore.firestore().collection("users").document(uid).collection("userUpvotes")
        
        Firestore.firestore().collection("reviews").document(reviewID)
            .updateData(["votes": review.votes - 1]) { error in
                if let error {
                    print("DEBUG: Failed to update review votes, \(error)")
                    return
                }
                
                userUpvotesCollectionRef.document(reviewID).delete { _ in
                    completion(review.votes - 1)
                }
            }
    }
    
    func didUserUpvoteReview(_ review: Review, completion: @escaping (Bool) -> Void) {
        guard let uid = getCurrentUserID() else { return }
        guard let reviewID = review.id else { return }
        
        Firestore.firestore().collection("users").document(uid).collection("userUpvotes").document(reviewID)
            .getDocument { snapshot, _ in
                guard let snapshot else { return }
                completion(snapshot.exists)
            }
    }
}

// MARK: - DownVote Logic
extension ReviewService {
    func downvoteReview(_ review: Review, completion: @escaping (Int) -> Void) {
        guard let uid = getCurrentUserID() else { return }
        guard let reviewID = review.id else { return }
        
        let userDownvotesCollectionRef = Firestore.firestore().collection("users").document(uid).collection("userDownvotes")
        
        Firestore.firestore().collection("reviews").document(reviewID)
            .updateData(["votes": review.votes - 1]) { error in
                if let error {
                    print("DEBUG: Failed to update review upvotes, \(error)")
                    return
                }
                
                userDownvotesCollectionRef.document(reviewID).setData([:]) { _ in
                    completion(review.votes - 1)
                }
            }
    }
    
    func unDownvoteReview(_ review: Review, completion: @escaping (Int) -> Void) {
        guard let uid = getCurrentUserID() else { return }
        guard let reviewID = review.id else { return }
//        guard review.votes > 0 else { return }
        
        let userDownvotesCollectionRef = Firestore.firestore().collection("users").document(uid).collection("userDownvotes")
        
        Firestore.firestore().collection("reviews").document(reviewID)
            .updateData(["votes": review.votes + 1]) { error in
                if let error {
                    print("DEBUG: Failed to update review votes, \(error)")
                    return
                }
                
                userDownvotesCollectionRef.document(reviewID).delete { _ in
                    completion(review.votes + 1)
                }
            }
    }
    
    func didUserDownvoteReview(_ review: Review, completion: @escaping (Bool) -> Void) {
        guard let uid = getCurrentUserID() else { return }
        guard let reviewID = review.id else { return }
        
        Firestore.firestore().collection("users").document(uid).collection("userDownvotes").document(reviewID)
            .getDocument { snapshot, _ in
                guard let snapshot else { return }
                completion(snapshot.exists)
            }
    }
}

// MARK: - Helpers
extension ReviewService {
    
    private func getCurrentUserID() -> String? {
        Auth.auth().currentUser?.uid
    }
    
}
