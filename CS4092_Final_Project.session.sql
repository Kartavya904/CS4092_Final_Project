-- Create All Required Tables for the Store
CREATE TABLE IF NOT EXISTS Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT,
    Brand VARCHAR(100),
    Size VARCHAR(50),
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL,
    Balance DECIMAL(10, 2) DEFAULT 0.00,
    Role VARCHAR(50) DEFAULT 'Customer'
);

CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(50) DEFAULT 'Issued',
    Total DECIMAL(10, 2) NOT NULL,
    DeliveryPlanID INT
);

CREATE TABLE IF NOT EXISTS OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS DeliveryPlans (
    DeliveryPlanID INT PRIMARY KEY,
    OrderID INT,
    DeliveryType VARCHAR(50) NOT NULL,
    DeliveryPrice DECIMAL(10, 2) NOT NULL,
    DeliveryDate DATE NOT NULL,
    ShipDate DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Warehouses (
    WarehouseID INT PRIMARY KEY,
    Address VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Stock (
    StockID INT PRIMARY KEY,
    WarehouseID INT,
    ProductID INT,
    Quantity INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Staff (
    StaffID INT PRIMARY KEY,
    StaffName VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    JobTitle VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Addresses (
    AddressID INT PRIMARY KEY,
    CustomerID INT,
    AddressType VARCHAR(50) NOT NULL,
    Address VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS CreditCards (
    CreditCardID INT PRIMARY KEY,
    CustomerID INT,
    CardNumber VARCHAR(16) NOT NULL,
    ExpirationDate DATE NOT NULL,
    CVV VARCHAR(3) NOT NULL,
    BillingAddressID INT
);

-- Insert Values in the Tables for the 1st time run.
INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Apparel'),
(2, 'Electronics'),
(3, 'Home Goods'),
(4, 'Books');

INSERT INTO Products (ProductID, ProductName, CategoryID, Brand, Size, Description, Price) VALUES
(1, 'T-Shirt', 1, 'BrandA', 'L', 'A comfortable cotton t-shirt', 19.99),
(2, 'Jeans', 1, 'BrandB', '32', 'Stylish blue jeans', 49.99),
(3, 'Laptop', 2, 'BrandC', '15-inch', 'High performance laptop', 899.99),
(4, 'Smartphone', 2, 'BrandD', '6-inch', 'Latest model smartphone', 699.99),
(5, 'Sofa', 3, 'BrandE', '3-seater', 'Comfortable living room sofa', 299.99),
(6, 'Dining Table', 3, 'BrandF', '6-seater', 'Elegant dining table', 199.99),
(7, 'Novel', 4, 'AuthorA', 'N/A', 'Best-selling novel', 14.99),
(8, 'Cookbook', 4, 'AuthorB', 'N/A', 'Delicious recipes', 24.99);

INSERT INTO Customers (CustomerID, CustomerName, Email, Password, Balance, Role) VALUES
(1, 'Alice', 'alice@example.com', 'hashed_password1', 0.00, 'Customer'),
(2, 'Bob', 'bob@example.com', 'hashed_password2', 0.00, 'Admin');

INSERT INTO Orders (OrderID, CustomerID, OrderDate, Status, Total, DeliveryPlanID) VALUES
(1, 1, '2024-07-01 10:00:00', 'Issued', 100.00, 1),
(2, 2, '2024-07-02 11:00:00', 'Issued', 200.00, 2);

INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 2, 19.99),
(2, 1, 2, 1, 49.99),
(3, 2, 3, 1, 899.99);

INSERT INTO DeliveryPlans (DeliveryPlanID, OrderID, DeliveryType, DeliveryPrice, DeliveryDate, ShipDate) VALUES
(1, 1, 'Standard', 5.00, '2024-07-10', '2024-07-08'),
(2, 2, 'Express', 15.00, '2024-07-09', '2024-07-07');

INSERT INTO Warehouses (WarehouseID, Address) VALUES
(1, '123 Main St, Anytown, USA'),
(2, '456 Elm St, Othertown, USA');

INSERT INTO Stock (StockID, WarehouseID, ProductID, Quantity) VALUES
(1, 1, 1, 100),
(2, 1, 2, 50),
(3, 2, 3, 30),
(4, 2, 4, 20);

INSERT INTO Staff (StaffID, StaffName, Address, Salary, JobTitle) VALUES
(1, 'John Doe', '789 Oak St, Anytown, USA', 50000.00, 'Manager'),
(2, 'Jane Smith', '101 Pine St, Othertown, USA', 40000.00, 'Sales Associate');

INSERT INTO Addresses (AddressID, CustomerID, AddressType, Address) VALUES
(1, 1, 'Shipping', '123 Maple St, Anytown, USA'),
(2, 1, 'Billing', '123 Maple St, Anytown, USA'),
(3, 2, 'Shipping', '456 Birch St, Othertown, USA'),
(4, 2, 'Billing', '456 Birch St, Othertown, USA');

INSERT INTO CreditCards (CreditCardID, CustomerID, CardNumber, ExpirationDate, CVV, BillingAddressID) VALUES
(1, 1, '1111222233334444', '2025-12-31', '123', 2),
(2, 2, '5555666677778888', '2026-06-30', '456', 4);

-- Add Foreign Keys for the Required Tables
ALTER TABLE Products
ADD CONSTRAINT fk_category
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);

ALTER TABLE Orders
ADD CONSTRAINT fk_customer
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE Orders
ADD CONSTRAINT fk_deliveryplan
FOREIGN KEY (DeliveryPlanID)
REFERENCES DeliveryPlans(DeliveryPlanID);

ALTER TABLE OrderItems
ADD CONSTRAINT fk_order
FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID);

ALTER TABLE OrderItems
ADD CONSTRAINT fk_product
FOREIGN KEY (ProductID)
REFERENCES Products(ProductID);

ALTER TABLE DeliveryPlans
ADD CONSTRAINT fk_order
FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID);

ALTER TABLE Stock
ADD CONSTRAINT fk_warehouse
FOREIGN KEY (WarehouseID)
REFERENCES Warehouses(WarehouseID);

ALTER TABLE Stock
ADD CONSTRAINT fk_product
FOREIGN KEY (ProductID)
REFERENCES Products(ProductID);

ALTER TABLE Addresses
ADD CONSTRAINT fk_customer
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE CreditCards
ADD CONSTRAINT fk_customer
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE CreditCards
ADD CONSTRAINT fk_billing_address
FOREIGN KEY (BillingAddressID)
REFERENCES Addresses(AddressID);

-- run to see if the code worked as intended
SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderItems;
SELECT * FROM DeliveryPlans;
SELECT * FROM Warehouses;
SELECT * FROM Stock;
SELECT * FROM Staff;
SELECT * FROM Addresses;
SELECT * FROM CreditCards;