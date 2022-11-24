# gestione_aste
## Introduction

The project consists in the creation of an auction management software, in which, by logging in with a username and password, the user is able to see information on the auction or on a particular piece, as well as have a complete overview of the depot. In addition, it is possible to add new sellers, pieces to the depot, and auctions.

## The software

The software is created with object-oriented programming using R. 

### Classes
*Auction house*: container class

*Seller*: contains the sellers' details, e.g. first name, last name, contact details, pieces sold... Each seller is associated with a unique identifier

*Stock*: contains the list of pieces and the list of auctions. Thanks to this class we can know which pieces are present and which have been in stock for too long. In fact, when a piece is sold it leaves the depot

*Piece*: associated with a unique identifier, this class contains all information about the piece: seller, description, estimate, photo, etc.

*Auction*: container class of the *Lot* class. Also identified by a unique identifier, it contains start and end dates of the auction, number of lots presented and sold, auction history

*Lot*: contains the reference to the piece by unique identifier, lot number, the hammer price

### MVP
the MVP consists of the development of the vendor management part. The Shiny library (R package that makes it easy to build interactive web apps straight from R) will be used for the interface.
