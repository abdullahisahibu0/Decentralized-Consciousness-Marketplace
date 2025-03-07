;; Mind State Tokenization Contract

(define-non-fungible-token mind-state uint)

(define-map mind-state-data
  { token-id: uint }
  {
    owner: principal,
    metadata: (string-utf8 256)
  }
)

(define-data-var last-token-id uint u0)

(define-public (mint-mind-state (metadata (string-utf8 256)))
  (let
    ((token-id (+ (var-get last-token-id) u1)))
    (try! (nft-mint? mind-state token-id tx-sender))
    (var-set last-token-id token-id)
    (ok (map-set mind-state-data
      { token-id: token-id }
      {
        owner: tx-sender,
        metadata: metadata
      }
    ))
  )
)

(define-read-only (get-mind-state-data (token-id uint))
  (map-get? mind-state-data { token-id: token-id })
)

