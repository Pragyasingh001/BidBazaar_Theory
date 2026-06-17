show databases;
create database bidbazar
use bidbazar;

CREATE TABLE User (
    UserID INTEGER PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(20),
    Password VARCHAR(255),
    Address VARCHAR(255),
    isBlocked BOOLEAN
);

CREATE TABLE ProductConfiguration (
    ConfigurationID INTEGER PRIMARY KEY,
    Created TIMESTAMP,
    ProductType VARCHAR(255),
    Product VARCHAR(255),
    Specifications JSON
);

CREATE TABLE ProductDetails (
    ProductID INTEGER PRIMARY KEY,
    ConfigurationID INTEGER,
    ProductType VARCHAR(255),
    Product VARCHAR(255),
    SpecificationValue JSON,
    LatestAuctionStatus VARCHAR(255),
    WinningBidID INTEGER,
    BuyerID INTEGER,
    Status VARCHAR(255),
    FOREIGN KEY (ConfigurationID) REFERENCES ProductConfiguration(ConfigurationID)
);

CREATE TABLE ProductInventory (
    ProductID INTEGER PRIMARY KEY,
    PickupAddress VARCHAR(255),
    PickupDateTime TIMESTAMP,
    AmountForSeller DECIMAL(10,2),
    DeliveryAddress VARCHAR(255),
    DeliveryDate TIMESTAMP,
    Status VARCHAR(255),
    SellerReceiptID INTEGER,
    BuyerReceiptID INTEGER,
    FOREIGN KEY (ProductID) REFERENCES ProductDetails(ProductID)
);

CREATE TABLE Auction (
    AuctionID INTEGER PRIMARY KEY,
    ProductID INTEGER,
    UserID INTEGER,
    AuctionStartTime TIMESTAMP,
    AuctionEndTime TIMESTAMP,
    AuctionStatus VARCHAR(255),
    AuctionType VARCHAR(255),
    SnippingFlag BOOLEAN,
    AuctionBasePrice DECIMAL(10,2),
    NegotiationEnabled BOOLEAN,
    FOREIGN KEY (ProductID) REFERENCES ProductDetails(ProductID),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE Bid (
    BidID INTEGER PRIMARY KEY,
    AuctionID INTEGER,
    ProductID INTEGER,
    UserID INTEGER,
    BidTimestamp TIMESTAMP,
    BidAmount DECIMAL(10,2),
    isWinningBid BOOLEAN,
    WinTimestamp TIMESTAMP,
    isAutoBid BOOLEAN,
    FOREIGN KEY (AuctionID) REFERENCES Auction(AuctionID),
    FOREIGN KEY (ProductID) REFERENCES ProductDetails(ProductID),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

CREATE TABLE AutoBid (
    BidID INTEGER PRIMARY KEY,
    StartingBid DECIMAL(10,2),
    MaxBid DECIMAL(10,2),
    StepRate DECIMAL(10,2),
    FOREIGN KEY (BidID) REFERENCES Bid(BidID)
);

CREATE TABLE Invoice (
    InvoiceID INTEGER PRIMARY KEY,
    BuyerID INTEGER,                
    SellerID INTEGER,              
    ReceiptID INTEGER,             
    ProductID INTEGER,
    CreatedTimestamp TIMESTAMP,
    SellerAmount DECIMAL(10,2),
    ServiceRate DECIMAL(10,2),
    FinalSellerPayout DECIMAL(10,2),
    BuyerPayout DECIMAL(10,2),
    InvoiceStatus VARCHAR(255),
    FOREIGN KEY (BuyerID) REFERENCES User(UserID),
    FOREIGN KEY (SellerID) REFERENCES User(UserID),
    FOREIGN KEY (ProductID) REFERENCES ProductDetails(ProductID)
);
show tables;







