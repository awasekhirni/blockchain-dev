# ---------------------------------------------------------------------- #
# Script generated with: DeZign for Databases V8.1.2                     #
# Target DBMS:           MySQL 5                                         #
# Project file:          BlockChainDB.dez                                #
# Project name:                                                          #
# Author:                 Syed Awase Khirni  awasekhirni@gmail.com       #
# Script type:           Database creation script                        #
# Created on:            2017-12-19 12:35                                #
# ---------------------------------------------------------------------- #


# ---------------------------------------------------------------------- #
# Add tables                                                             #
# ---------------------------------------------------------------------- #

# ---------------------------------------------------------------------- #
# Add table "Block"                                                      #
# ---------------------------------------------------------------------- #
use exblockchaindb;

CREATE TABLE `Block` (
    `BlockId` BIGINT NOT NULL,
    `PrevBlockId` BIGINT NOT NULL,
    `TransactionCount` INTEGER NOT NULL,
    `MerkleRoot` BINARY(40) NOT NULL,
    `Nonce` INTEGER NOT NULL,
    `Difficulty` BINARY(40) NOT NULL,
    `BlockSignature` BINARY(40) NOT NULL,
    `PrevBlockSignature` BINARY(40) NOT NULL,
    `CreatedDateTime` DATETIME NOT NULL,
    CONSTRAINT `PK_Block` PRIMARY KEY (`BlockId`)
);

# ---------------------------------------------------------------------- #
# Add table "TransactionType"                                            #
# ---------------------------------------------------------------------- #

CREATE TABLE `TransactionType` (
    `TransactionTypeId` SMALLINT NOT NULL,
    `TransactionTypeDesc` VARCHAR(100) NOT NULL,
    CONSTRAINT `PK_TransactionType` PRIMARY KEY (`TransactionTypeId`)
);

# ---------------------------------------------------------------------- #
# Add table "User"                                                       #
# ---------------------------------------------------------------------- #

CREATE TABLE `User` (
    `UserId` BIGINT NOT NULL,
    `UserFirstName` VARCHAR(200) NOT NULL,
    `UserLastName` VARCHAR(100) NOT NULL,
    `UserDOB` DATE NOT NULL,
    `UserEmail` VARCHAR(200) NOT NULL,
    `UserPhone` VARCHAR(40) NOT NULL,
    CONSTRAINT `PK_User` PRIMARY KEY (`UserId`)
);

# ---------------------------------------------------------------------- #
# Add table "Message"                                                    #
# ---------------------------------------------------------------------- #

CREATE TABLE `Message` (
    `MessageId` BIGINT NOT NULL,
    `Subject` VARCHAR(250) NOT NULL,
    `Body` VARCHAR(2000) NOT NULL,
    `ReadDateTime` DATETIME NOT NULL,
    `CreatedDateTime` DATETIME NOT NULL,
    `FromUserId` BIGINT NOT NULL,
    `ToUserId` VARCHAR(40) NOT NULL,
    CONSTRAINT `PK_Message` PRIMARY KEY (`MessageId`, `FromUserId`, `ToUserId`)
);

# ---------------------------------------------------------------------- #
# Add table "Transaction"                                                #
# ---------------------------------------------------------------------- #

CREATE TABLE `Transaction` (
    `TransactionId` BIGINT NOT NULL,
    `TransactionTypeId` SMALLINT NOT NULL,
    `TransactionHash` BINARY(40) NOT NULL,
    `HashVersion` BIGINT NOT NULL,
    `TransactionDateTime` DATETIME NOT NULL,
    `BlockId` BIGINT NOT NULL,
    CONSTRAINT `PK_Transaction` PRIMARY KEY (`TransactionId`, `TransactionTypeId`, `BlockId`)
);

# ---------------------------------------------------------------------- #
# Add table "MerkleTreeIntermediateNode"                                 #
# ---------------------------------------------------------------------- #

CREATE TABLE `MerkleTreeIntermediateNode` (
    `MerkleTreeIntermediateNodeid` BIGINT NOT NULL,
    `TransactionId1` BIGINT NOT NULL,
    `TransactionId2` BIGINT NOT NULL,
    `MerkleTreeIntermediateNodeId1` BIGINT NOT NULL,
    `MerkleTreeIntermediateNodeId2` BIGINT NOT NULL,
    `Depth` SMALLINT,
    `NodeHash` BINARY(40),
    `BlockId` BIGINT NOT NULL,
    `TransactionId` BIGINT NOT NULL,
    `TransactionTypeId` SMALLINT NOT NULL,
    CONSTRAINT `PK_MerkleTreeIntermediateNode` PRIMARY KEY (`MerkleTreeIntermediateNodeid`, `TransactionId1`, `TransactionId2`, `MerkleTreeIntermediateNodeId1`, `MerkleTreeIntermediateNodeId2`, `BlockId`, `TransactionId`, `TransactionTypeId`)
);

# ---------------------------------------------------------------------- #
# Add foreign key constraints                                            #
# ---------------------------------------------------------------------- #

ALTER TABLE `Transaction` ADD CONSTRAINT `TransactionType_Transaction` 
    FOREIGN KEY (`TransactionTypeId`) REFERENCES `TransactionType` (`TransactionTypeId`);

ALTER TABLE `Transaction` ADD CONSTRAINT `Block_Transaction` 
    FOREIGN KEY (`BlockId`) REFERENCES `Block` (`BlockId`);

ALTER TABLE `Message` ADD CONSTRAINT `User_Message` 
    FOREIGN KEY (`FromUserId`) REFERENCES `User` (`UserId`);

ALTER TABLE `Message` ADD CONSTRAINT `User_Message` 
    FOREIGN KEY (`FromUserId`) REFERENCES `User` (`UserId`);

ALTER TABLE `MerkleTreeIntermediateNode` ADD CONSTRAINT `Transaction_MerkleTreeIntermediateNode` 
    FOREIGN KEY (`TransactionId`, `TransactionTypeId`, `BlockId`) REFERENCES `Transaction` (`TransactionId`,`TransactionTypeId`,`BlockId`);

ALTER TABLE `MerkleTreeIntermediateNode` ADD CONSTRAINT `Transaction_MerkleTreeIntermediateNode` 
    FOREIGN KEY (`TransactionId`, `TransactionTypeId`, `BlockId`) REFERENCES `Transaction` (`TransactionId`,`TransactionTypeId`,`BlockId`);
