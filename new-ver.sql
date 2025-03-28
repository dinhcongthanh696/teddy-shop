USE [master]
GO
/****** Object:  Database [TeddyBearOnlineShop]    Script Date: 3/19/2025 11:01:48 PM ******/
CREATE DATABASE [TeddyBearOnlineShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TeddyBearOnlineShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TeddyBearOnlineShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TeddyBearOnlineShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TeddyBearOnlineShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TeddyBearOnlineShop] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TeddyBearOnlineShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TeddyBearOnlineShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET  MULTI_USER 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TeddyBearOnlineShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TeddyBearOnlineShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TeddyBearOnlineShop] SET QUERY_STORE = ON
GO
ALTER DATABASE [TeddyBearOnlineShop] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TeddyBearOnlineShop]
GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[status] [bit] NOT NULL,
	[userId] [int] NULL,
	[updateTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[updateDate] [datetime] NULL,
	[status] [bit] NULL,
	[thumbnail] [nvarchar](255) NOT NULL,
	[blogType] [nvarchar](25) NULL,
	[campaignId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Campaign]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Campaign](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](25) NOT NULL,
	[description] [nvarchar](max) NULL,
	[status] [bit] NULL,
	[startDate] [datetime] NULL,
	[endDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartDetail]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cartId] [int] NULL,
	[productId] [int] NULL,
	[quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[content] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContentManagement]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentManagement](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[header_text_color] [varchar](50) NULL,
	[header_background_color] [varchar](50) NULL,
	[footer_text_color] [varchar](50) NULL,
	[footer_background_color] [varchar](50) NULL,
	[web_name] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[totalCost] [int] NOT NULL,
	[status] [int] NULL,
	[userId] [int] NULL,
	[orderDate] [datetime] NULL,
	[arrivedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[orderId] [int] NULL,
	[productId] [int] NULL,
	[quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](25) NULL,
	[categoryId] [int] NULL,
	[typeId] [int] NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImage]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[source] [nvarchar](255) NOT NULL,
	[productId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductType]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rating]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rating](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[rating] [int] NOT NULL,
	[createDate] [datetime] NULL,
	[userId] [int] NULL,
	[commentId] [int] NULL,
	[productId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Salary]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salary](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[salary] [int] NOT NULL,
	[userId] [int] NULL,
	[updateTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Setting]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Setting](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](25) NOT NULL,
	[status] [bit] NOT NULL,
	[content] [nvarchar](255) NULL,
	[createDate] [datetime] NULL,
	[description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Size]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Size](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](25) NOT NULL,
	[quantity] [int] NULL,
	[price] [int] NULL,
	[productId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userName] [nvarchar](255) NOT NULL,
	[profilePic] [nvarchar](255) NULL,
	[email] [nvarchar](255) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[phoneNumber] [nvarchar](12) NOT NULL,
	[location] [nvarchar](255) NULL,
	[createdDate] [datetime] NULL,
	[roleId] [int] NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[roleName] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserVoucher]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserVoucher](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[voucherId] [int] NULL,
	[userId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ViewCount]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ViewCount](
	[date] [datetime] NOT NULL,
	[viewCount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Voucher]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Voucher](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](25) NOT NULL,
	[discount] [int] NOT NULL,
	[status] [bit] NULL,
	[startDate] [datetime] NULL,
	[endDate] [datetime] NULL,
	[campaignId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VoucherProduct]    Script Date: 3/19/2025 11:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VoucherProduct](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[voucherId] [int] NULL,
	[productId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([id], [name], [status]) VALUES (1, N'Gấu Bông May Mắn', NULL)
INSERT [dbo].[Category] ([id], [name], [status]) VALUES (2, N'Gấu bông Ghi Âm', NULL)
INSERT [dbo].[Category] ([id], [name], [status]) VALUES (3, N'Pikachu', NULL)
INSERT [dbo].[Category] ([id], [name], [status]) VALUES (4, N'Stitch', NULL)
INSERT [dbo].[Category] ([id], [name], [status]) VALUES (5, N'Cinnamaroll', NULL)
INSERT [dbo].[Category] ([id], [name], [status]) VALUES (6, N'Thú Bông Cảm Xúc', NULL)
INSERT [dbo].[Category] ([id], [name], [status]) VALUES (7, N'Gối Ôm Dài', NULL)
INSERT [dbo].[Category] ([id], [name], [status]) VALUES (8, N'Gối Ôm Béo', NULL)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([id], [totalCost], [status], [userId], [orderDate], [arrivedAt]) VALUES (1, 500000, 1, 1, CAST(N'2025-03-17T20:42:51.723' AS DateTime), CAST(N'2025-03-20T20:42:51.723' AS DateTime))
INSERT [dbo].[Order] ([id], [totalCost], [status], [userId], [orderDate], [arrivedAt]) VALUES (2, 750000, 1, 2, CAST(N'2025-03-17T20:42:51.723' AS DateTime), CAST(N'2025-03-19T20:42:51.723' AS DateTime))
INSERT [dbo].[Order] ([id], [totalCost], [status], [userId], [orderDate], [arrivedAt]) VALUES (3, 1200000, 0, 3, CAST(N'2025-03-17T20:42:51.723' AS DateTime), NULL)
INSERT [dbo].[Order] ([id], [totalCost], [status], [userId], [orderDate], [arrivedAt]) VALUES (4, 890000, 1, 4, CAST(N'2025-03-17T20:42:51.723' AS DateTime), CAST(N'2025-03-22T20:42:51.723' AS DateTime))
INSERT [dbo].[Order] ([id], [totalCost], [status], [userId], [orderDate], [arrivedAt]) VALUES (5, 300000, 1, 5, CAST(N'2025-03-17T20:42:51.723' AS DateTime), CAST(N'2025-03-18T20:42:51.723' AS DateTime))
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([id], [orderId], [productId], [quantity]) VALUES (1, 1, 2, 1)
INSERT [dbo].[OrderDetail] ([id], [orderId], [productId], [quantity]) VALUES (2, 1, 5, 1)
INSERT [dbo].[OrderDetail] ([id], [orderId], [productId], [quantity]) VALUES (3, 2, 3, 1)
INSERT [dbo].[OrderDetail] ([id], [orderId], [productId], [quantity]) VALUES (4, 2, 4, 1)
INSERT [dbo].[OrderDetail] ([id], [orderId], [productId], [quantity]) VALUES (5, 3, 1, 1)
INSERT [dbo].[OrderDetail] ([id], [orderId], [productId], [quantity]) VALUES (6, 4, 2, 1)
INSERT [dbo].[OrderDetail] ([id], [orderId], [productId], [quantity]) VALUES (7, 4, 3, 1)
INSERT [dbo].[OrderDetail] ([id], [orderId], [productId], [quantity]) VALUES (8, 5, 5, 1)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (1, N'Stitch Ngồi', 4, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (2, N'Stitch Ôm Tim', 4, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (3, N'Stitch Bông Tím', 4, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (4, N'Gối Cổ Kèm Mũ Stitch', 4, 3, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (5, N'Móc Khóa Stitch Bông', 4, 2, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (6, N'Cinnamoroll Đeo Túi', 5, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (7, N'Kuromi Đeo Túi', 5, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (8, N'Kuromi Cupid', 5, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (9, N'Chó Vàng Purin', 5, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (10, N'Kuromi Galaxy', 5, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (11, N'Gấu Bông Teddy', 2, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (12, N'Capybara Hồng', 2, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (13, N'Babyboo Ghi Âm', 2, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (14, N'Head Tales Ghi Âm', 2, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (15, N'Hug Me Teddy', 2, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (16, N'Capybara Thần Tài', 1, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (17, N'Rồng Vàng', 1, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (18, N'Rồng Búp Bê Baby', 1, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (19, N'Rồng Xanh Ôm Cá', 1, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (20, N'Bộ 4 Rồng Happy', 1, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (21, N'Hải Cẩu Sushi', 8, 3, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (22, N'Hải Cẩu Mũm Mĩm', 8, 3, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (23, N'Chó Bông Corgi', 8, 3, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (24, N'Heo Lulu Ong', 8, 3, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (25, N'Hải Cẩu Bông', 8, 3, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (26, N'Gối Ôm Hải Cẩu', 7, 3, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (27, N'Husky Má Tim', 7, 3, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (28, N'Shiba Giơ Tay', 7, 3, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (29, N'Lotso Mặt Hoa', 7, 3, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (30, N'Cà Rốt Lông', 7, 3, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (31, N'Pikachu Tai Đen', 3, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (32, N'Purin Hồng', 3, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (33, N'Kabigon', 3, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (34, N'Eve Tai Dài', 3, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (35, N'Pikachu Bông Mềm', 3, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (36, N'Mihi Cảm Xúc', 6, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (37, N'Bạch Tuộc Khổng Lồ', 6, 1, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (38, N'Móc Khóa Bạch Tuộc', 6, 2, NULL)
INSERT [dbo].[Product] ([id], [name], [categoryId], [typeId], [status]) VALUES (39, N'Bạch Tuộc Siêu To', 6, 1, NULL)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImage] ON 

INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (1, N'images/stitchNgoiDoiMuOmKem.jpg', 1)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (2, N'images/stitch-ngoi-doi-mu-om-kem-6.jpg', 1)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (3, N'images/stitch-ngoi-doi-mu-om-kem-5.jpg', 1)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (4, N'images/stitch-ngoi-doi-mu-om-kem-7.jpg', 1)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (5, N'images/Gau-Bong-Stitch-Om-Tim-5-500x500.jpg', 2)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (6, N'images/Gau-Bong-Stitch-Om-Tim-7.jpg', 2)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (7, N'images/Gau-Bong-Stitch-Om-Tim-8.jpg', 2)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (8, N'images/Gau-Bong-Stitch-Om-Tim-9.jpg', 2)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (9, N'images/Stitch-tim-nho-5-500x500.jpg', 3)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (10, N'images/Stitch-tim-nho-1.jpg', 3)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (11, N'images/Stitch-tim-nho-12.jpg', 3)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (12, N'images/Stitch-mu-4-500x500.jpg', 4)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (13, N'images/goi-co-mu-stitch-4.jpg', 4)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (14, N'images/goi-co-mu-stitch-5.jpg', 4)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (15, N'images/moc-khoa-stitch-tai-dai-2-500x500.jpg', 5)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (16, N'images/stitch-tai-dai.jpg', 5)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (17, N'images/moc-khoa-stitch-tai-dai-1.jpg', 5)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (18, N'images/Az4628962022474_38ced04d3aecc838fbe9ca96c04a1b9b-jpg.webp', 6)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (19, N'images/Az4626448838208_9a32f3f15c4de0a8b2157b37fd8e49d5-jpg.webp', 6)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (20, N'images/Az4626448966985_044c7987fd95f2b2d76552b9d12757ca-jpg.webp', 6)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (21, N'images/Az4626450573660_c1db553568115e837f3bfda80721e1fc-500x500.webp', 7)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (22, N'images/Az4626450656119_a510a7c3037aebf5a7c772a88da818a2-jpg.webp', 7)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (23, N'images/Az4626450770633_2937451d388cc7fd53658e53a2ad593d-jpg.webp', 7)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (24, N'images/kuromi-kupid-2-jpg-500x500.webp', 8)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (25, N'images/kuromi-kupid-9-jpg.webp', 8)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (26, N'images/kuromi-kupid-7-jpg.webp', 8)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (27, N'images/Az4628962050328_0dfd2fa3689719a3e29049867259deca-500x500.webp', 9)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (28, N'images/Az4623341273462_1aac1d87b072f12e61097356900742a7-jpg.webp', 9)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (29, N'images/Az4623341240740_70cc567f29be4a7e7bcd26b87d95e200-jpg.webp', 9)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (30, N'images/kuromi-galaxy-6-500x500.webp', 10)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (31, N'images/kuromi-galaxy-8-jpg.webp', 10)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (32, N'images/kuromi-galaxy-7-jpg.webp', 10)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (33, N'images/gau-ghi-am-17-1.jpg', 11)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (34, N'images/gau-ghi-am-13.jpg', 11)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (35, N'images/gau-ghi-am-5-1.jpg', 11)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (36, N'images/Capybara-hong-deo-bong-nhay-hat-1-500x500.jpg', 12)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (37, N'images/Capybara-hong-deo-bong-nhay-hat-6.jpg', 12)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (38, N'images/Gau-Bong-BabyBoo-Ghi-Am-1-500x500.jpg', 13)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (39, N'images/gau-ghi-am-17-1-500x500.jpg', 14)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (40, N'images/gau-ghi-am-17-500x500.jpg', 15)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (41, N'images/Chuot-capybara-than-tai-1-500x500.jpg', 16)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (42, N'images/Az4995136766781_ee8bba271ecfedffd684b7738c71504f-jpg-500x500.webp', 17)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (43, N'images/Az4926699272776_687fc371d5557fcecb50b21167d8c45d-jpg-500x500.webp', 18)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (44, N'images/rong-xanh-om-ca-5-jpg-500x500.webp', 19)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (45, N'images/Az4986240969507_a00ee2db46fbf0d54d649394385beed0-jpg-500x500.webp', 20)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (46, N'images/Hai-Cau-Sushi-7-500x500.jpg', 21)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (47, N'images/Hai-Cau-Mum-Mim-11-500x500.jpg', 22)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (48, N'images/cho-corgi-beo-500x500.webp', 23)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (49, N'images/heo-lulu-ong-nam-9-500x500.webp', 24)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (50, N'images/hai-cau-bien-500x500.webp', 25)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (51, N'images/goi-om-hai-cau-2-500x500.jpg', 26)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (52, N'images/goi-om-hussky-ma-tim-xam-nam-1-500x500.webp', 27)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (53, N'images/goi-om-cho-nam-gio-tay-500x500.webp', 28)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (54, N'images/Goi-om-Lotso-mat-hoa-1-500x500.jpg', 29)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (55, N'images/ca-rot-long-1-500x500.jpg', 30)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (56, N'images/pokemon-tai-den-4.jpg', 31)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (57, N'images/Purin-Hong-Pokemon-1.jpg', 32)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (58, N'images/Kabigon-Pokemon-12.jpg', 33)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (59, N'images/Eve-Tai-Dai-Pokemon-11-500x500.jpg', 34)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (60, N'images/pikachu-bong-mem-3-500x500.jpg', 35)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (61, N'images/mihi-cam-xuc.jpg', 36)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (62, N'images/bach-tuoc-cam-xuc-khong-lo.jpg', 37)
INSERT [dbo].[ProductImage] ([id], [source], [productId]) VALUES (63, N'images/moc-khoa-bach-tuoc-cam-xuc-19-500x500.jpg', 38)
SET IDENTITY_INSERT [dbo].[ProductImage] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductType] ON 

INSERT [dbo].[ProductType] ([id], [name]) VALUES (1, N'Gấu Bông')
INSERT [dbo].[ProductType] ([id], [name]) VALUES (3, N'Gối Ôm')
INSERT [dbo].[ProductType] ([id], [name]) VALUES (2, N'Móc Khóa')
SET IDENTITY_INSERT [dbo].[ProductType] OFF
GO
SET IDENTITY_INSERT [dbo].[Size] ON 

INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (1, N'55cm', 300, 65000, 1)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (2, N'70cm', 300, 85000, 1)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (3, N'90cm', 300, 115000, 1)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (4, N'55cm', 300, 65000, 2)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (5, N'70cm', 300, 85000, 2)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (6, N'90cm', 300, 115000, 2)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (7, N'55cm', 300, 75000, 3)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (8, N'70cm', 300, 95000, 3)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (9, N'90cm', 300, 125000, 3)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (10, N'35cm', 300, 35000, 4)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (11, N'60cm', 300, 65000, 4)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (12, N'80cm', 300, 95000, 4)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (13, N'18cm', 300, 35000, 5)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (14, N'55cm', 300, 65000, 6)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (15, N'70cm', 300, 85000, 6)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (16, N'90cm', 300, 115000, 6)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (17, N'55cm', 300, 65000, 7)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (18, N'70cm', 300, 85000, 7)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (19, N'90cm', 300, 115000, 7)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (20, N'55cm', 300, 65000, 8)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (21, N'70cm', 300, 85000, 8)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (22, N'90cm', 300, 115000, 8)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (23, N'55cm', 300, 65000, 9)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (24, N'70cm', 300, 85000, 9)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (25, N'90cm', 300, 115000, 9)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (26, N'55cm', 300, 65000, 10)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (27, N'70cm', 300, 85000, 10)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (28, N'90cm', 300, 115000, 10)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (29, N'55cm', 300, 65000, 11)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (30, N'70cm', 300, 85000, 11)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (31, N'90cm', 300, 115000, 11)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (32, N'55cm', 300, 65000, 12)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (33, N'70cm', 300, 85000, 12)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (34, N'90cm', 300, 115000, 12)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (35, N'55cm', 300, 65000, 13)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (36, N'70cm', 300, 85000, 13)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (37, N'90cm', 300, 115000, 13)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (38, N'55cm', 300, 65000, 14)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (39, N'70cm', 300, 85000, 14)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (40, N'90cm', 300, 115000, 14)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (41, N'55cm', 300, 65000, 15)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (42, N'70cm', 300, 85000, 15)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (43, N'90cm', 300, 115000, 15)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (44, N'55cm', 300, 65000, 16)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (45, N'70cm', 300, 85000, 16)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (46, N'90cm', 300, 115000, 16)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (47, N'55cm', 300, 65000, 17)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (48, N'70cm', 300, 85000, 17)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (49, N'90cm', 300, 115000, 17)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (50, N'55cm', 300, 65000, 18)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (51, N'70cm', 300, 85000, 18)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (52, N'90cm', 300, 115000, 18)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (53, N'55cm', 300, 65000, 19)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (54, N'70cm', 300, 85000, 19)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (55, N'90cm', 300, 115000, 19)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (56, N'55cm', 300, 65000, 20)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (57, N'70cm', 300, 85000, 20)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (58, N'90cm', 300, 115000, 20)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (59, N'115cm', 300, 95000, 21)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (60, N'135cm', 300, 115000, 21)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (61, N'175cm', 300, 215000, 21)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (62, N'115cm', 300, 95000, 22)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (63, N'135cm', 300, 115000, 22)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (64, N'175cm', 300, 215000, 22)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (65, N'115cm', 300, 95000, 23)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (66, N'135cm', 300, 115000, 23)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (67, N'175cm', 300, 215000, 23)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (68, N'115cm', 300, 95000, 24)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (69, N'135cm', 300, 115000, 24)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (70, N'175cm', 300, 215000, 24)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (71, N'115cm', 300, 95000, 25)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (72, N'135cm', 300, 115000, 25)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (73, N'175cm', 300, 215000, 25)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (74, N'115cm', 300, 95000, 26)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (75, N'135cm', 300, 115000, 26)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (76, N'175cm', 300, 215000, 26)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (77, N'115cm', 300, 95000, 27)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (78, N'135cm', 300, 115000, 27)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (79, N'175cm', 300, 215000, 27)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (80, N'115cm', 300, 95000, 28)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (81, N'135cm', 300, 115000, 28)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (82, N'175cm', 300, 215000, 28)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (83, N'115cm', 300, 95000, 29)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (84, N'135cm', 300, 115000, 29)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (85, N'175cm', 300, 215000, 29)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (86, N'115cm', 300, 95000, 30)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (87, N'135cm', 300, 115000, 30)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (88, N'175cm', 300, 215000, 30)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (89, N'55cm', 300, 65000, 31)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (90, N'70cm', 300, 85000, 31)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (91, N'90cm', 300, 115000, 31)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (92, N'55cm', 300, 65000, 32)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (93, N'70cm', 300, 85000, 32)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (94, N'90cm', 300, 115000, 32)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (95, N'55cm', 300, 65000, 33)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (96, N'70cm', 300, 85000, 33)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (97, N'90cm', 300, 115000, 33)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (98, N'55cm', 300, 65000, 34)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (99, N'70cm', 300, 85000, 34)
GO
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (100, N'90cm', 300, 115000, 34)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (101, N'55cm', 300, 65000, 35)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (102, N'70cm', 300, 85000, 35)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (103, N'90cm', 300, 115000, 35)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (104, N'55cm', 300, 65000, 36)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (105, N'70cm', 300, 85000, 36)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (106, N'90cm', 300, 115000, 36)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (107, N'55cm', 300, 65000, 37)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (108, N'70cm', 300, 85000, 37)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (109, N'90cm', 300, 115000, 37)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (110, N'15cm', 300, 15000, 38)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (111, N'55cm', 300, 65000, 39)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (112, N'70cm', 300, 85000, 39)
INSERT [dbo].[Size] ([id], [name], [quantity], [price], [productId]) VALUES (113, N'90cm', 300, 115000, 39)
SET IDENTITY_INSERT [dbo].[Size] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([id], [userName], [profilePic], [email], [password], [phoneNumber], [location], [createdDate], [roleId], [status]) VALUES (1, N'User1', N'images/usericon.jpg', N'User1@gmail.com', N'Minh553311@', N'0334372394', N'To Huu', CAST(N'2025-03-17T20:42:51.700' AS DateTime), 1, NULL)
INSERT [dbo].[User] ([id], [userName], [profilePic], [email], [password], [phoneNumber], [location], [createdDate], [roleId], [status]) VALUES (2, N'Seller1', N'images/usericon.jpg', N'Seller1@gmail.com', N'Minh553311@', N'0334372354', N'To Huu', CAST(N'2025-03-17T20:42:51.703' AS DateTime), 2, NULL)
INSERT [dbo].[User] ([id], [userName], [profilePic], [email], [password], [phoneNumber], [location], [createdDate], [roleId], [status]) VALUES (3, N'Marketing1', N'images/usericon.jpg', N'Marketing1@gmail.com', N'Minh553311@', N'0334372321', N'To Huu', CAST(N'2025-03-17T20:42:51.710' AS DateTime), 3, NULL)
INSERT [dbo].[User] ([id], [userName], [profilePic], [email], [password], [phoneNumber], [location], [createdDate], [roleId], [status]) VALUES (4, N'Manager1', N'images/usericon.jpg', N'Manager1@gmail.com', N'manager', N'0334372621', N'To Huu', CAST(N'2025-03-17T20:42:51.713' AS DateTime), 4, NULL)
INSERT [dbo].[User] ([id], [userName], [profilePic], [email], [password], [phoneNumber], [location], [createdDate], [roleId], [status]) VALUES (5, N'admin', N'images/usericon.jpg', N'Admin1@gmail.com', N'admin', N'0334310121', N'To Huu', CAST(N'2025-03-17T20:42:51.717' AS DateTime), 5, NULL)
INSERT [dbo].[User] ([id], [userName], [profilePic], [email], [password], [phoneNumber], [location], [createdDate], [roleId], [status]) VALUES (6, N'Thanh Dinh', N'images/usericon.jpg', N'thanhdo9901@gmail.com', N'Abc123@', N'0866624403', N'abc', CAST(N'2025-03-18T23:14:16.683' AS DateTime), 1, NULL)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRole] ON 

INSERT [dbo].[UserRole] ([id], [roleName]) VALUES (5, N'Admin')
INSERT [dbo].[UserRole] ([id], [roleName]) VALUES (1, N'Customer')
INSERT [dbo].[UserRole] ([id], [roleName]) VALUES (4, N'Manager')
INSERT [dbo].[UserRole] ([id], [roleName]) VALUES (3, N'Marketing')
INSERT [dbo].[UserRole] ([id], [roleName]) VALUES (2, N'Seller')
SET IDENTITY_INSERT [dbo].[UserRole] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Campaign__72E12F1BED57BAE8]    Script Date: 3/19/2025 11:01:50 PM ******/
ALTER TABLE [dbo].[Campaign] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Category__72E12F1BBCCDA1C1]    Script Date: 3/19/2025 11:01:50 PM ******/
ALTER TABLE [dbo].[Category] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__ProductI__0CEA5442170EC749]    Script Date: 3/19/2025 11:01:50 PM ******/
ALTER TABLE [dbo].[ProductImage] ADD UNIQUE NONCLUSTERED 
(
	[source] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__ProductT__72E12F1B1CA058FD]    Script Date: 3/19/2025 11:01:50 PM ******/
ALTER TABLE [dbo].[ProductType] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Setting__72E12F1B7F89E17A]    Script Date: 3/19/2025 11:01:50 PM ******/
ALTER TABLE [dbo].[Setting] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User__4849DA0133BBF7C8]    Script Date: 3/19/2025 11:01:50 PM ******/
ALTER TABLE [dbo].[User] ADD UNIQUE NONCLUSTERED 
(
	[phoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User__AB6E61642307ACB5]    Script Date: 3/19/2025 11:01:50 PM ******/
ALTER TABLE [dbo].[User] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__UserRole__B1947861CC05FABF]    Script Date: 3/19/2025 11:01:50 PM ******/
ALTER TABLE [dbo].[UserRole] ADD UNIQUE NONCLUSTERED 
(
	[roleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Voucher__72E12F1B1B1DE2BF]    Script Date: 3/19/2025 11:01:50 PM ******/
ALTER TABLE [dbo].[Voucher] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Attendance] ADD  DEFAULT (getdate()) FOR [updateTime]
GO
ALTER TABLE [dbo].[Blog] ADD  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[Campaign] ADD  DEFAULT (getdate()) FOR [startDate]
GO
ALTER TABLE [dbo].[CartDetail] ADD  DEFAULT ((1)) FOR [quantity]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT (getdate()) FOR [orderDate]
GO
ALTER TABLE [dbo].[OrderDetail] ADD  DEFAULT ((1)) FOR [quantity]
GO
ALTER TABLE [dbo].[Rating] ADD  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[Setting] ADD  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ('images/usericon.jpg') FOR [profilePic]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[Voucher] ADD  DEFAULT (getdate()) FOR [startDate]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Blog]  WITH CHECK ADD FOREIGN KEY([campaignId])
REFERENCES [dbo].[Campaign] ([id])
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[CartDetail]  WITH CHECK ADD FOREIGN KEY([cartId])
REFERENCES [dbo].[Cart] ([id])
GO
ALTER TABLE [dbo].[CartDetail]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([orderId])
REFERENCES [dbo].[Order] ([id])
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([categoryId])
REFERENCES [dbo].[Category] ([id])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([typeId])
REFERENCES [dbo].[ProductType] ([id])
GO
ALTER TABLE [dbo].[ProductImage]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD FOREIGN KEY([commentId])
REFERENCES [dbo].[Comment] ([id])
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Salary]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Size]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD FOREIGN KEY([roleId])
REFERENCES [dbo].[UserRole] ([id])
GO
ALTER TABLE [dbo].[UserVoucher]  WITH CHECK ADD FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[UserVoucher]  WITH CHECK ADD FOREIGN KEY([voucherId])
REFERENCES [dbo].[Voucher] ([id])
GO
ALTER TABLE [dbo].[Voucher]  WITH CHECK ADD FOREIGN KEY([campaignId])
REFERENCES [dbo].[Campaign] ([id])
GO
ALTER TABLE [dbo].[VoucherProduct]  WITH CHECK ADD FOREIGN KEY([productId])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[VoucherProduct]  WITH CHECK ADD FOREIGN KEY([voucherId])
REFERENCES [dbo].[Voucher] ([id])
GO
USE [master]
GO
ALTER DATABASE [TeddyBearOnlineShop] SET  READ_WRITE 
GO
