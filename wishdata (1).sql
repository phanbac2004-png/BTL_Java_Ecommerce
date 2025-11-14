-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 11, 2025 at 07:22 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wishdata`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `id` int(11) NOT NULL,
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pass` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isSell` int(11) DEFAULT NULL,
  `isAdmin` int(11) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`id`, `user`, `pass`, `isSell`, `isAdmin`, `phone`, `email`) VALUES
(1, 'Adam', '123456', 1, 1, NULL, NULL),
(16, 'Hoang Duong', '123456', 1, 1, NULL, NULL),
(32, 'hd', '123', 0, 0, '0347113353', NULL),
(33, 'nhd', '123', 0, 0, NULL, NULL),
(34, 'admin', 'admin', 1, 1, '0123456789', 'hoanggduongg2004@gmail.com'),
(35, 'lan anh', '123', 0, 0, '0374373190', 'lananhnguyenthi213@gmail.com'),
(36, 'phanbac', '123456', 0, 0, '0900000000', 'phanbac2004@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `AccountID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `Amount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`AccountID`, `ProductID`, `Amount`) VALUES
(1, 17, 2),
(32, 1, 5),
(32, 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `cid` int(11) NOT NULL,
  `cname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`cid`, `cname`) VALUES
(1, 'ÁO THUN'),
(2, 'ĐỒ BỘ'),
(3, 'QUẦN'),
(4, 'ÁO KHOÁC'),
(5, 'PHỤ KIỆN'),
(6, 'HOODIES');

-- --------------------------------------------------------

--
-- Table structure for table `orderdetails`
--

CREATE TABLE `orderdetails` (
  `id` int(11) NOT NULL,
  `orderID` int(11) DEFAULT NULL,
  `productID` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orderdetails`
--

INSERT INTO `orderdetails` (`id`, `orderID`, `productID`, `amount`, `price`) VALUES
(1, 1, 1, 1, 100.000),
(2, 1, 2, 1, 120.000),
(3, 2, 2, 1, 120.000),
(4, 3, 2, 3, 120.000),
(5, 4, 2, 3, 120.000),
(6, 5, 2, 1, 120.000),
(7, 5, 4, 1, 150.000),
(8, 5, 5, 1, 150.000),
(9, 6, 3, 1, 130.000),
(10, 7, 3, 3, 130.000),
(11, 8, 16, 2, 120000.000),
(12, 9, 4, 3, 150000.000);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `accountID` int(11) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `orderDate` datetime DEFAULT current_timestamp(),
  `totalPrice` decimal(10,3) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `accountID`, `phone`, `address`, `orderDate`, `totalPrice`, `status`) VALUES
(1, 32, '0347113353', 'aaa', '2025-11-03 16:10:22', 220.000, 'Processing'),
(2, 32, '0347113353', 'dddd', '2025-11-06 08:23:34', 120.000, 'Processing'),
(3, 35, '0374373190', '12A', '2025-11-06 11:01:21', 360.000, 'Processing'),
(4, 35, '0347113353', '12A', '2025-11-06 11:06:51', 360.000, 'Processing'),
(5, 32, '0347113353', 'asd', '2025-11-06 11:34:45', 420.000, 'Processing'),
(6, 32, '0347113353', 'xxx', '2025-11-06 11:40:49', 130.000, 'Processing'),
(7, 32, '0347113353', 'aaa', '2025-11-06 11:46:06', 390.000, 'Processing'),
(8, 32, '0347113353', 'Linh Nam', '2025-11-06 23:50:36', 240000.000, 'Processing'),
(9, 32, '0347113353', 'Chuong my', '2025-11-11 00:41:14', 450000.000, 'Processing');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cateID` int(11) DEFAULT NULL,
  `sell_ID` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 10,
  `color` varchar(50) DEFAULT NULL,
  `size` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `image`, `price`, `title`, `description`, `cateID`, `sell_ID`, `quantity`) VALUES
(1, 'Áo thun cotton in hình', 'https://image.hm.com/assets/hm/67/34/6734398c255afdcd501f9bcc0355ab0ffb0ea03c.jpg?imwidth=384', 100000.000, 'Màu hồng nhạt/Đỏ đậm/Xanh lá, Mẫu họa tiết', 'Áo thun bằng cotton jersey mềm, in hình. Cổ tròn, viền diềm nhún với khuy bấm ở một bên (trừ các cỡ 2-4Y), vai ráp trễ và tay ngắn.', 1, 1, 10),
(2, 'Áo thun cotton in hoạ tiết', 'https://image.hm.com/assets/hm/fc/d2/fcd2a0f3b7fff5c2d995ceab2b958c6b7f5beb64.jpg?imwidth=1260', 120000.000, 'Màu kem/Vàng mù tạt/Xám đậm, Stitch, Khối màu, Stitch, Lilo & Stitch, Disney', 'Áo thun bằng cotton jersey mềm có hoạ tiết in phía trước. Cổ tròn, viền gân nổi có khuy bấm ở một bên (trừ các cỡ 2-4Y).', 1, 6, 10),
(3, 'Áo thun cotton in hoạ tiết', 'https://image.hm.com/assets/hm/35/14/3514772138825023fa221c82a4ff8105316aad4f.jpg?imwidth=384', 130000.000, 'Màu xám đốm/Vàng/Đỏ/Xanh dương/Trắng, Donald Duck, Mickey Mouse, Pluto, Chuột Mickey, Disney', 'Áo thun bằng cotton jersey mềm có hoạ tiết in phía trước. Cổ tròn, viền gân nổi có khuy bấm ở một bên (trừ các cỡ 2-4Y).', 1, 7, 10),
(4, 'Áo khoác lót giả lông cừu', 'https://image.hm.com/assets/hm/ec/a7/eca726759681b06e9e1cf41a17292f3d625faa6e.jpg?imwidth=1260', 150000.000, 'Màu xanh tím than/Nâu/Xanh dương nhạt/Be, Mẫu họa tiết, Dinosaurs', 'Áo khoác in hình dệt thoi mềm với mũ có thể tháo rời. Cổ đứng, khoá kéo dọc thân trước với miếng chặn cằm chống trầy xước và chun bọc ở cổ tay và gấu. Lót vải giả lông cừu.', 4, 1, 7),
(5, 'Áo khoác lót giả lông cừu', 'https://image.hm.com/assets/hm/14/f5/14f55b733638775caa8559c373ea35f87ba658a5.jpg?imwidth=1260', 150000.000, 'Màu kem/Xanh lá/Đỏ, Hoa', 'Áo khoác in hình dệt thoi mềm với mũ có thể tháo rời. Cổ đứng, khoá kéo dọc thân trước với miếng chặn cằm chống trầy xước và chun bọc ở cổ tay và gấu. Lót vải giả lông cừu.', 4, 6, 10),
(6, 'Quần nhung tăm cotton', 'https://image.hm.com/assets/hm/14/ca/14cafce0933ed41b22b7737eabc6a5224ff88b34.jpg?imwidth=1260', 160000.000, 'Màu nâu, Màu trơn', 'Quần dài bằng vải nhung tăm cotton mềm. Dáng thoải mái ở phần hông và đùi với ống hơi côn. Cạp co giãn có dây rút, nẹp kéo khoá giả, túi trang trí hai bên và túi sau mở.', 3, 7, 10),
(7, 'Áo thun dáng thụng in hình', 'https://image.hm.com/assets/hm/da/97/da978f7afcd0c90ae2cddda9e639c33bcbeeba29.jpg?imwidth=1260', 170000.000, 'Màu xanh tím than/Trắng/Vàng, Kẻ sọc, LEGO minifigure face, LEGO Brand, LEGO', 'Áo thun dáng thụng bằng cotton jersey mềm, in hình. Viền gân nổi quanh cổ và vai ráp trễ nhiều.', 1, 14, 10),
(8, 'Áo thun cotton có chi tiết thêu', 'https://image.hm.com/assets/hm/06/c2/06c2f9c9829bf4f480bc2f91c0b0dca3a91cb688.jpg?imwidth=1260', 150000.000, 'Màu xanh tím than/Cam, Excavator', 'Áo thun dáng rộng bằng cotton jersey mềm có túi ngực may đáp với một hoạ tiết thêu nhỏ. Cổ tròn, viền gân nổi, vai ráp trễ và tay ngắn.', 1, 15, 10),
(9, 'Áo khoác denim in hình', 'https://image.hm.com/assets/hm/1e/14/1e14f517717188bd9a8d2668a5fee8bfbb4b56b8.jpg?imwidth=2160', 180000.000, 'Màu trắng/Xanh dương, Stitch, Lilo & Stitch, Disney', 'Áo khoác bằng cotton denim dày dặn có hoạ tiết in. Có cổ, khuy dọc thân trước, túi ngực có nắp và tay dài với măng sét cài khuy.', 4, 14, 10),
(10, 'Quần jogger hộp có mặt trái chải xù', 'https://image.hm.com/assets/hm/05/20/05201216bf1d8c594e5e717cd939e2d20cae5677.jpg?imwidth=1260', 180000.000, 'Màu xám đậm, Màu trơn', 'Quần jogger dáng hộp bằng vải nỉ có mặt trái chải xù mềm và chi tiết xếp ly cố định. Cạp co giãn, điều chỉnh được với dây rút trang trí, túi ống quần có nắp và chun bọc ở gấu.', 3, 15, 10),
(11, 'Áo có cổ áo thêu ren lỗ', 'https://image.hm.com/assets/hm/8e/39/8e392b220e324f6ba1ff1cd499aa232bc4aa2eb6.jpg?imwidth=1260', 150000.000, 'Màu be nhạt, Màu trơn', 'Áo bằng cotton jersey mềm có cổ tròn với lá cổ bằng vải dệt thoi diềm nhún thêu ren lỗ có mép sò điệp. Tay dài, ráp lăng với cổ tay bo chun mảnh.', 1, 17, 10),
(12, 'Bộ 2 món cotton in hình', 'https://image.hm.com/assets/hm/b2/dd/b2dd93b90c44130aad498bc225ad5dc0e3512af4.jpg?imwidth=1260', 165000.000, 'Màu be nhạt/Trắng/Đỏ/Đen, Hello Kitty, Mẫu họa tiết, Hello Kitty, hearts, Hello Kitty', 'Hàng mới về\r\nBộ gồm áo thun và quần short đạp xe bằng cotton jersey mềm, in hình. Áo thun cổ tròn, viền gân nổi có khuy bấm ở một bên và vai ráp trễ. Quần short đạp xe với cạp co giãn điều chỉnh được.', 2, 19, 10),
(13, 'Bộ 2 món vải nỉ in hình', 'https://image.hm.com/assets/hm/08/f7/08f7ff094fef8438397bb9434623ca58673c1f44.jpg?imwidth=1260', 185000.000, 'Màu be nhạt/Trắng/Đỏ/Đen, Mẫu họa tiết, Hello Kitty, Hello Kitty', 'Hàng mới về\r\nBộ gồm áo và quần jogger bằng vải nỉ với mặt trái chải xù mềm và hình in toàn bộ. Áo có cổ tròn, viền gân nổi và khuy bấm trên một bên vai (trừ các cỡ 2–4Y). Vai ráp trễ, tay dài với cổ tay và gấu bo gân nổi. Quần jogger với cạp chun bọc có dây rút trang trí và gấu bo chun bọc.', 2, 18, 10),
(14, 'Áo thun in hình', 'https://image.hm.com/assets/hm/4f/c4/4fc4e516d1ca95684e48b85510977b6ffd7b06f5.jpg?imwidth=1260', 200000.000, 'Màu xám nhạt/Đỏ/Xanh dương, Spider-Man saving the city, Spider-Man, Người nhện, Disney/Marvel', 'Áo thun bằng cotton jersey mềm in hình có viền gân nổi quanh cổ và vai ráp trễ.', 1, 1, 10),
(15, 'Quần jogger kiểu túi hộp', 'https://image.hm.com/assets/hm/15/8d/158d7d734b2228f8cdafc15d848d3d176269a517.jpg?imwidth=1260', 100000.000, 'Màu be, Màu trơn', 'Quần jogger bằng vải nỉ cotton có mặt trái chải xù mềm và túi ống quần có nắp. Cạp co giãn, điều chỉnh được với dây rút trang trí và chun bọc ở gấu.', 3, 6, 10),
(16, 'Cargo joggers', 'https://image.hm.com/assets/hm/a4/cd/a4cdfc0c50f979f558511fffb038cede38525c8c.jpg?imwidth=1260', 120000.000, 'Màu xanh kaki đậm, Màu trơn', 'Quần jogger kiểu túi hộp dệt thoi co giãn làm từ cotton pha có túi ống quần có nắp. Cạp co giãn có dây rút, nẹp kéo khoá giả, túi chéo hai bên và túi sau giả. Gấu co giãn.', 3, 7, 10),
(17, 'Bộ 3 đôi tất xù vòng', 'https://image.hm.com/assets/hm/e4/a8/e4a8f33180dc254108b008e5f667508dde08592d.jpg?imwidth=1260', 179000.000, 'Màu be đốm/Trắng, Snowflakes', 'Hàng mới về\r\nTất cotton pha dệt kim mềm, mịn với cổ tất gập, mặt trái xù vòng, mềm và có các chi tiết chống trượt.', 5, 1, 10),
(18, 'Bộ 2 món quần yếm và áo', 'https://image.hm.com/assets/hm/27/23/2723dd11baf4dcc81dfeb94b983ef73ab9471478.jpg?imwidth=1260', 120000.000, 'Màu xanh tím than/Trắng/Ngọc lam, Dinosaurs', 'Bộ gồm quần yếm bằng vải nhung tăm mềm và áo bằng jersey gân nổi, cả hai đều làm từ cotton. Quần yếm có các hoạ tiết thêu, dây vai có thể điều chỉnh và túi may đáp ở phía trước và trên ống quần. Áo dài tay có cổ tròn và khuy bấm ở một bên (trừ các cỡ 2-4Y).', 2, 7, 10),
(19, 'Bộ 2 món quần yếm và áo', 'https://image.hm.com/assets/hm/70/ca/70cab3965307bc49c6bb2971e034e4b4c6c8b366.jpg?imwidth=1260', 129000.000, 'Màu xám/Trắng/be, Dogs', 'Bộ gồm quần yếm bằng denim mềm và áo bằng jersey gân nổi, cả hai đều làm từ cotton. Quần yếm có chi tiết thêu nhỏ, dây vai cài khuy bấm điều chỉnh được, và khuy bấm ở hai bên. Túi may đáp ở bên trên và hai bên và khuy bấm ẩn dọc ống quần để dễ thay (trừ các cỡ 1-4Y). Áo có cổ tròn, khuy bấm trên một bên vai và tay dài.', 2, 4, 10),
(20, 'Bộ 5 đôi tất xù vòng chống trượt', 'https://image.hm.com/assets/hm/b4/df/b4dff50410c166aa548d05bef38331afe4b86762.jpg?imwidth=1260', 249000.000, 'Màu nâu đậm/Nâu/Be hồng/Be nhạt/Trắng', 'Tất bằng cotton pha dệt kim mềm, mịn với cổ tất gập và các chi tiết chống trượt. Mặt trái vải xù vòng mềm.', 5, 1, 10),
(21, 'Bộ 2 đôi quần tất', 'https://image.hm.com/assets/hm/3a/52/3a52bca859fe39825f3e2e837ec4b5d9747ea1d6.jpg?imwidth=1260', 299000.000, 'Màu be đốm/Be nhạt đốm, Màu trơn', 'Quần tất bằng vải pha sợi bông mềm, dệt sợi mảnh với cạp thun co giãn.', 5, 1, 10),
(22, 'Mũ beanie đính trang trí', 'https://image.hm.com/assets/hm/b1/9d/b19da92bea20d1cac0219bf3b63e24839a2b9d20.jpg?imwidth=1260', 249000.000, 'Màu đen/Trắng, Mickey Mouse, Chuột Mickey, Disney', 'Mũ beanie bằng cotton mềm dệt kim có miếng đính trang trí và viền mũ lật.', 5, 1, 10),
(23, 'Giày ba-lê bệt đính nơ', 'https://image.hm.com/assets/hm/01/5a/015acf316a222b00470fe34c1f247eb0fd9e29ea.jpg?imwidth=1260', 449000.000, 'Màu đen, Màu trơn', 'Hàng mới về\r\nGiày ba-lê bệt có mũi tròn và đai ngang bàn chân đính nơ trang trí. Lớp lót và đế trong mềm với xốp kỹ thuật Cellfit™ giúp tăng độ thoải mái. Đế ngoài xẻ rãnh.', 5, 1, 10),
(24, 'Bộ 2 món gồm áo kiểu và quần legging', 'https://image.hm.com/assets/hm/1c/ad/1cadd8d18a9927ae855ff65103c4b109c2ef24e7.jpg?imwidth=1260', 599000.000, 'Màu xám đậm/Trắng, Màu trơn', 'Hàng mới về\r\nBộ gồm áo kiểu bằng vải nhung tăm cotton và quần legging bằng cotton jersey gân nổi. Áo kiểu có cổ tròn và cổ Peter Pan diềm đăng ten, khuy dọc thân trước và cổ tay co giãn, diềm nhún. Quần legging có cạp co giãn, điều chỉnh được.', 2, 1, 10),
(25, 'Bộ 3 món vải jersey in hình', 'https://image.hm.com/assets/hm/16/71/1671192908ff4b22f1281f731281024543e94e33.jpg?imwidth=1260', 449000.000, 'Màu hồng nhạt/Xanh lá/Hồng, Hoa', 'Hàng mới về\r\nBộ gồm áo, quần legging và một băng đô đồng bộ, đều làm từ cotton jersey in hình hoa. Áo dài tay có cổ tròn, phía sau khoét giọt lệ cài khuy và phần nhún bèo bên trên kéo dài qua vai. Quần legging có cạp co giãn, điều chỉnh được. Băng đô có chi tiết nút thắt.', 2, 1, 10),
(26, 'Giày ba-lê bệt kim tuyến', 'https://image.hm.com/assets/hm/ef/bc/efbcf164b1e0644b284fe3ffebf7f8bffe06355a.jpg?imwidth=1260', 449000.000, 'Màu bạc, Màu trơn, Elsa, Nữ hoàng băng giá, Disney', 'Giày ba-lê bệt kim tuyến với quai chun trên mu bàn chân và quai tròn bằng lụa sọc ngang phía sau. Lót vải satin và đế trong in hình bằng xốp kỹ thuật Cellfit™ giúp tăng độ thoải mái. Đế ngoài xẻ rãnh.', 5, 1, 10),
(27, 'Túi đeo vai có hoạ tiết in', 'https://image.hm.com/assets/hm/8b/6a/8b6a6134558ea0b9350078853fa4c7bb81623f27.jpg?imwidth=1260', 249000.000, 'Màu tím nhạt/Hồng nhạt/Trắng, Kuromi, Kuromi, cherries, Kuromi', 'Túi dệt thoi dày dặn có viền diềm nhún và hoạ tiết in. Khoá kéo bên trên và quai đeo vai bọc vải may xếp nếp. Có lớp lót.', 5, 1, 10),
(28, 'Bộ 2 món vải nỉ', 'https://image.hm.com/assets/hm/c7/42/c742478ea99b4973d47d236f690fd3817120af9b.jpg?imwidth=1260', 699000.000, 'Màu be nhạt/Xanh lá/Xanh dương/Đen, Mẫu họa tiết, Mickey Mouse, Goofy, Donald Duck, Chuột Mickey, Disney', 'Hàng mới về\r\nBộ gồm áo và quần jogger đồng bộ bằng vải nỉ với mặt trái chải xù mềm. Áo có mũ có lớp lót đính tai trang trí bên trên và thân trước đáp chéo, vai ráp trễ và cổ tay và gấu bo gân nổi. Quần jogger với cạp chun có dây rút trang trí và gấu bo chun bọc.', 2, 1, 10),
(29, 'Boot lót xù', 'https://image.hm.com/assets/hm/d6/f7/d6f761bd9006e035d37d89c2e92d4362d2fe6509.jpg?imwidth=1260', 499000.000, 'Màu be, Màu trơn', 'Boot bằng vải mềm cài khoá dán ở phía sau và lớp lót xù ấm áp. Đế trong làm từ xốp kỹ thuật Cellfit™ giúp tăng độ thoải mái.', 5, 1, 10),
(30, 'Áo hoodie in hình', 'https://image.hm.com/assets/hm/2c/9d/2c9d626e0d3ceb9fb4b3de685024e96679eccbc9.jpg?imwidth=1260', 599000.000, 'Màu xanh dương khói nhạt/Đỏ/Trắng/Vàng, Play more together, LEGO figure, LEGO Brand, LEGO', 'Áo hoodie dáng rộng bằng vải nỉ in hình với mặt trái chải xù mềm. Mũ đáp chéo phía trước, có lớp lót, vai ráp trễ, tay dài, cổ tay và gấu bo gân nổi.', 6, 1, 10);

-- Seed color/size values for filtering demos
UPDATE `product` SET `color`='pink', `size`='S' WHERE `id` IN (1,25);
UPDATE `product` SET `color`='blue', `size`='M' WHERE `id` IN (2,8,9,30);
UPDATE `product` SET `color`='gray', `size`='L' WHERE `id` IN (3,10,14);
UPDATE `product` SET `color`='beige', `size`='S' WHERE `id` IN (11,24,29);
UPDATE `product` SET `color`='green', `size`='M' WHERE `id` IN (6,18,28);
UPDATE `product` SET `color`='white', `size`='XL' WHERE `id` IN (9);
UPDATE `product` SET `color`='black', `size`='M' WHERE `id` IN (22,23);

-- Ensure 'red' color exists for demo filter
UPDATE `product` SET `color`='red', `size`='S' WHERE `id` IN (1,14);
UPDATE `product` SET `color`='red', `size`='M' WHERE `id` IN (3,7);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`AccountID`,`ProductID`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_od_order` (`orderID`),
  ADD KEY `fk_od_product` (`productID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_order_account` (`accountID`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `orderdetails`
--
ALTER TABLE `orderdetails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD CONSTRAINT `fk_od_order` FOREIGN KEY (`orderID`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `fk_od_product` FOREIGN KEY (`productID`) REFERENCES `product` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_order_account` FOREIGN KEY (`accountID`) REFERENCES `account` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
