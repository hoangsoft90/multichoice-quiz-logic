-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 22, 2014 at 05:11 PM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `test1`
--

-- --------------------------------------------------------

--
-- Table structure for table `acc`
--

CREATE TABLE IF NOT EXISTS `acc` (
  `user` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `pass` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `acc`
--

INSERT INTO `acc` (`user`, `pass`) VALUES
('phan phú', ''),
('phan phÃº', ''),
('quách hoàng', ''),
('cộng hoà', '');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(11) NOT NULL,
  `message` text NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `address`, `phone`, `message`, `status`) VALUES
(1, 'huy', 'nhokngoc90@gmail.com', 'sahdkashdad', '20348920423', '', 'pending'),
(2, 'huy1', 'nhokngoc90@gmail.com', 'asadsd', '0219432434', '', 'pending'),
(3, 'adawd', 'nhokngoc90@gmail.com', 'salnfdskf', '32429342094', '', 'done'),
(4, 'adawd', 'nhokngoc90@gmail.com', 'salnfdskf', '32429342094', 'kshfskehfkeshfker', 'done'),
(5, 'adawd', 'nhokngoc90@gmail.com', 'salnfdskf', '32429342094', 'kshfskehfkeshfker', 'pending'),
(6, 'san pham1', 'quachhoang_2005@yahoo.com', 'sfdsadasd', 'sdnfskdfnks', 'worhw9e47298347wihrwkefrserf', 'done'),
(7, '', '', '', '', '', 'pending'),
(8, 'Quach Van Hoang', 'quachhoang_2005@yahoo.com', 'NgÃµ 55/35, thanh lÃ¢n, thanh Ä‘Ã m, hoÃ ng mai hÃ  ná»™i', '0219432434', 'Tin nháº¯n cá»§a báº¡n Ä‘á»ƒ láº¡i Ä‘á»ƒ chÃºng tÃ´i cÃ³ thá»ƒ trá»£ giÃºp cho báº¡n.', 'pending'),
(9, 'eqwe', 'weqwe', 'qeqwe', 'eqe', 'eqeqeqe', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `customers1`
--

CREATE TABLE IF NOT EXISTS `customers1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `province` varchar(100) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `message` text NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `customers1`
--

INSERT INTO `customers1` (`id`, `name`, `email`, `province`, `phone`, `message`, `status`) VALUES
(1, 'aisodhsd', 'sfdsfsdflsdmf', 'HÃ  Ná»™i', '2434234-234', '', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `ksn_audiobooks`
--

CREATE TABLE IF NOT EXISTS `ksn_audiobooks` (
  `book_id` int(11) NOT NULL AUTO_INCREMENT,
  `book_title` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `links` text NOT NULL,
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ungho_ksn`
--

CREATE TABLE IF NOT EXISTS `ungho_ksn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `amount` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `ungho_ksn`
--

INSERT INTO `ungho_ksn` (`id`, `fullname`, `message`, `amount`) VALUES
(1, 'hoang', 'chuc mung khosachnoi', 'Vietel:100.000 VND'),
(2, 'hoang', 'chuc mung khosachnoi', 'Vietel:100.000 VND'),
(3, 'hoang', 'chuc mung khosachnoi', 'Vietel:100.000 VND'),
(4, 'hoang', 'chuc mung khosachnoi', 'Vietel:100.000 VND'),
(5, 'hoang', 'chuc mung khosachnoi', 'Vietel:100.000 VND'),
(6, 'hoang', 'chuc mung khosachnoi', 'Vietel:100.000 VND'),
(7, 'hoang', 'chuc mung khosachnoi', 'Vietel:100.000 VND'),
(8, 'hoang', 'chuc mung khosachnoi', 'Vietel:100.000 VND');

-- --------------------------------------------------------

--
-- Table structure for table `vcn_answers`
--

CREATE TABLE IF NOT EXISTS `vcn_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` int(11) NOT NULL,
  `answer` text COLLATE utf8_unicode_ci NOT NULL,
  `answer_link_question` text COLLATE utf8_unicode_ci NOT NULL,
  `text2next_question` text COLLATE utf8_unicode_ci NOT NULL,
  `answer_object_type` int(11) NOT NULL,
  `link_object_type` int(11) NOT NULL,
  `partner` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=116 ;

--
-- Dumping data for table `vcn_answers`
--

INSERT INTO `vcn_answers` (`id`, `question`, `answer`, `answer_link_question`, `text2next_question`, `answer_object_type`, `link_object_type`, `partner`) VALUES
(1, 1, 'Hợp đồng lao động hà nội', '2', 'Điều kiện tốt', 0, 0, 0),
(3, 1, 'Bảo hiểm nhân thọ', '0', '', 0, 0, 0),
(4, 1, 'Giấy phép kinh doanh', '0', '', 0, 0, 0),
(5, 1, 'Không có các giấy tờ trên', '0', '', 0, 0, 0),
(6, 2, 'var birth=document.createElement(''input'');\r\nanswer.appendChild(birth);\r\nanswer.appendChild(document.createTextNode(''(VD: 09/04/1990)''));\r\n', '$( birth ).datepicker({onSelect:function(dateText, inst) {\nvar d1=new Date(dateText);\nvar d2=new Date(today);\nvar age=d2.getYear()-d1.getYear();\nif(age<21 || age>60){\nnext_question_listener(6,[data.answer_id,birth.value]);\nset_text2next(6,''Tuoi 21 den 60 moi dc vay'');\n} else next_question_listener(4,[data.answer_id,birth.value]);\n},changeMonth: true,changeYear: true});\n$(birth).datepicker(''option'', ''dateFormat'', ''yy-mm-dd'' );\n$(birth).datepicker(''setDate'', ''1986-06-19'');', '', 1, 1, 0),
(9, 4, 'Dưới 2 triệu', '6', 'Mức lương cần trên 2 triệu mới được vay', 0, 0, 0),
(10, 4, 'Từ 2 triệu đến dưới 3 triệu', '15', '', 0, 0, 0),
(11, 5, '', '', '', 0, 0, 0),
(12, 6, 'answer.style.textAlign=''center'';\r\nappend(''Nhấn vào nút này để gửi quá trình tư vấn của bạn:'');\r\nvar but1=c_but1(''Lưu hồ sơ'');\r\nbut1.className=''saveCustomerBut'';\r\ndlg_opt({auto:1,button:but1});\r\nanswer_callback(function(){set_question_history();});', '', '', 1, 0, 0),
(13, 7, 'var cty=document.createElement(''input'');\r\nanswer.appendChild(cty);\r\nvar but=c_but1(''Tiếp'');\r\nbut.onclick=cty_next;\r\nanswer.appendChild(but);', 'function cty_next(){\r\np.ref.get(1).dbtable[''company'']=cty.value;\r\nnext_question(8);\r\n}', '', 1, 1, 0),
(14, 8, 'TNHH Việt Nam', '9', '', 0, 0, 0),
(15, 8, 'Tư nhân Việt Nam', '9', '', 0, 0, 0),
(16, 8, 'Cổ phần thành lập từ 3 năm trở lên', '12', '', 0, 0, 0),
(17, 8, 'Cổ phần thành lập từ 6 tháng trở lên và dưới 3 năm', '9', '', 0, 0, 0),
(18, 8, 'Cổ phần thành lập dưới 6 tháng', '6', '', 0, 0, 0),
(19, 9, 'TNHH/ Tư nhân từ 5 tỷ trở lên', '11', '', 0, 0, 0),
(20, 9, 'TNHH/ Tư nhân dưới 5 tỷ', '15', '', 0, 0, 0),
(21, 10, 'Sản xuất và Thương mại', '12', '', 0, 0, 0),
(22, 10, 'Hành chính sự nghiệp. Tôi là Công an/ Bộ đội/ Có quân hàm', '6', '', 0, 0, 0),
(23, 10, 'Hành chính sự nghiệp nhưng tôi không phải là Công an/ Bộ đội/ Có quân hàm', '12', '', 0, 0, 0),
(24, 10, 'Khác', '12', '', 0, 0, 0),
(25, 11, 'Từ 3 năm trở lên', '12', '', 0, 0, 0),
(26, 11, 'Dưới 3 năm', '15', '', 0, 0, 0),
(27, 12, 'TP.HCM trừ Củ Chi, Cần Giờ', '13', '', 0, 0, 0),
(28, 12, 'TP.HCM (Củ Chi, Cần Giờ)', '14', '', 0, 0, 0),
(29, 12, 'Bình Dương (Thủ dầu 1, Thuận an, Dĩ an, Tân Yên, Bến cát)', '13', '', 0, 0, 0),
(30, 12, 'Bình Dương (khu vực khác khu vực trên)', '6', 'Chúng tôi không hỗ trợ khu vực khác ngoài bình dương.', 0, 0, 0),
(31, 12, 'Đồng Nai (Biên hoà, Long Thành)', '13', '', 0, 0, 0),
(32, 12, 'Đồng Nai (Nhơn Trạch)', '14', '', 0, 0, 0),
(33, 12, 'Đồng Nai (Trảng Bom)', '16', '', 0, 0, 0),
(34, 12, 'Đồng Nai (khu vực khác khu vực trên)', '6', 'Chúng tôi không hỗ trợ ngoài đồng nai', 0, 0, 0),
(35, 12, 'Long An (Bến Lức)', '13', '', 0, 0, 0),
(36, 12, 'Long An (Đức Hòa, Cần Giuộc)', '14', '', 0, 0, 0),
(37, 12, 'Long An (Tân An, Châu Thành, Tân Trụ, Thủ Thừa)', '16', '', 0, 0, 0),
(38, 12, 'Long An (khu vực khác khu vực trên)', '6', 'Không hỗ trợ ngoài long an', 0, 0, 0),
(39, 12, 'Hà Nội', '14', '', 0, 0, 0),
(40, 12, 'Tỉnh thành khác', '6', 'Không hỗ trợ ngoài tỉnh lẻ', 0, 0, 0),
(41, 13, 'TP.HCM trừ Củ Chi, Cần Giờ', '5,29', '', 0, 0, 0),
(42, 13, 'TP.HCM (Củ Chi, Cần Giờ)', '5,19', '', 0, 0, 0),
(43, 13, 'Bình Dương (Thủ dầu 1, Thuận an, Dĩ an, Tân Yên, Bến cát)', '5,29', '', 0, 0, 0),
(44, 13, 'Bình Dương (khu vực khác khu vực trên)', '6', '', 0, 0, 0),
(45, 13, 'Đồng Nai (Biên hoà, Long Thành)', '5,29', '', 0, 0, 0),
(46, 13, 'Đồng Nai (Nhơn Trạch)', '5,19', '', 0, 0, 0),
(47, 13, 'Đồng Nai (Trảng Bom)', '18', '', 0, 0, 0),
(48, 13, 'Đồng Nai (khu vực khác khu vực trên)', '6', '', 0, 0, 0),
(49, 13, 'Long An (Bến Lức)', '5,29', '', 0, 0, 0),
(50, 13, 'Long An (Đức Hòa, Cần Giuộc)', '5,19', '', 0, 0, 0),
(51, 13, 'Long An (Tân An, Châu Thành, Tân Trụ, Thủ Thừa)', '18', '', 0, 0, 0),
(52, 13, 'Long An (khu vực khác khu vực trên)', '6', '', 0, 0, 0),
(53, 13, 'Tỉnh thành khác', '6', '', 0, 0, 0),
(54, 14, 'TP.HCM', '5,19', '', 0, 0, 0),
(55, 14, 'Bình Dương (Thủ dầu 1, Thuận an, Dĩ an, Tân Yên, Bến cát)', '5,19', '', 0, 0, 0),
(56, 14, 'Bình Dương (khu vực khác khu vực trên)', '6', '', 0, 0, 0),
(57, 14, 'Đồng Nai (Biên hoà, Long Thành, Nhơn Trạch)', '5,19', '', 0, 0, 0),
(58, 14, 'Đồng Nai (khu vực khác khu vực trên)', '6', '', 0, 0, 0),
(59, 14, 'Long An (Bến Lức, Cần Giuộc, Đức Hòa)', '5,19', '', 0, 0, 0),
(60, 14, 'Long An (khu vực khác khu vực trên)', '6', '', 0, 0, 0),
(61, 14, 'Hà Nội trừ quận Hoàng Mai', '5,19', '', 0, 0, 0),
(62, 14, 'Hà Nội quận Hoàng Mai', '6', '', 0, 0, 0),
(63, 14, 'Tỉnh thành khác', '6', '', 0, 0, 0),
(64, 15, 'Rồi', '6', '', 0, 0, 0),
(65, 15, 'Chưa', '16', '', 0, 0, 0),
(66, 16, 'TP.HCM trừ Củ Chi, Cần Giờ', '17', '', 0, 0, 0),
(67, 16, 'TP.HCM (Củ Chi, Cần Giờ)', '6', '', 0, 0, 0),
(68, 16, 'Bình Dương (Thủ dầu 1, Thuận an, Dĩ an, Tân Yên, Bến cát)', '17', '', 0, 0, 0),
(69, 16, 'Bình Dương (khu vực khác khu vực trên)', '6', '', 0, 0, 0),
(70, 16, 'Đồng Nai (Biên hoà, Long Thành, Trảng Bom)', '17', '', 0, 0, 0),
(71, 16, 'Đồng Nai (khu vực khác khu vực trên)', '6', '', 0, 0, 0),
(72, 16, 'Long An (Bến Lức, Tân An, Châu Thành, Tân Trụ, Thủ Thừa)', '17', '', 0, 0, 0),
(73, 16, 'Long An (khu vực khác khu vực trên)', '6', '', 0, 0, 0),
(74, 16, 'Tỉnh thành khác', '6', '', 0, 0, 0),
(75, 17, 'TP.HCM trừ Củ Chi, Cần Giờ', '18', '', 0, 0, 0),
(76, 17, 'TP.HCM (Củ Chi, Cần Giờ)', '6', '', 0, 0, 0),
(77, 17, 'Bình Dương (Thủ dầu 1, Thuận an, Dĩ an, Tân Yên, Bến cát)', '18', '', 0, 0, 0),
(78, 17, 'Bình Dương (khu vực khác khu vực trên)', '6', '', 0, 0, 0),
(79, 17, 'Đồng Nai (Biên hoà, Long Thành, Trảng Bom)', '18', '', 0, 0, 0),
(80, 17, 'Đồng Nai (khu vực khác khu trên)', '6', '', 0, 0, 0),
(81, 17, 'Long An (Bến Lức, Tân An, Châu Thành, Tân Trụ, Thủ Thừa)', '18', '', 0, 0, 0),
(82, 17, 'Long An (khu vực khác khu vực trên)', '6', '', 0, 0, 0),
(83, 17, 'Tỉnh thành khác', '6', '', 0, 0, 0),
(84, 18, 'answer.style.textAlign=''center'';\r\nappend(''Nháº¥n vÃ o nÃºt nÃ y Ä‘á»ƒ gá»­i quÃ¡ trÃ¬nh tÆ° váº¥n cá»§a báº¡n:'');\r\nvar but1=c_but1(''LÆ°u há»“ sÆ¡'');\r\nbut1.className=''saveCustomerBut'';\r\ndlg_opt({auto:1,button:but1});\r\nanswer_callback(function(){set_question_history(''VPBank'');});', '', '', 1, 0, 0),
(85, 19, 'Rá»“i', '6', '', 0, 0, 0),
(86, 19, 'ChÆ°a', '20', '', 0, 0, 0),
(87, 20, 'DÆ°á»›i 3 thÃ¡ng', '21', '', 0, 0, 0),
(88, 20, 'Tá»« 3 thÃ¡ng trá»Ÿ lÃªn', '23', '', 0, 0, 0),
(89, 21, 'Chuyá»ƒn khoáº£n', '6', '', 0, 0, 0),
(90, 21, 'Tiá»n máº·t', '23', '', 0, 0, 0),
(91, 22, 'DÆ°á»›i 6 thÃ¡ng', '21', '', 0, 0, 0),
(92, 22, 'Tá»« 6 thÃ¡ng Ä‘áº¿n dÆ°á»›i 1 nÄƒm', '23', '', 0, 0, 0),
(93, 22, 'Tá»« 1 nÄƒm trá»Ÿ lÃªn', '23', '', 0, 0, 0),
(94, 23, 'Tá»« 4 triá»‡u trá»Ÿ lÃªn', '27', '', 0, 0, 0),
(95, 23, 'Tá»« 3 Ä‘áº¿n dÆ°á»›i 4 triá»‡u', '24', '', 0, 0, 0),
(96, 23, 'DÆ°á»›i 3 triá»‡u', '6', '', 0, 0, 0),
(97, 24, '', '', '', 0, 0, 0),
(98, 25, 'DÆ°á»›i 1 nÄƒm', '26', '', 0, 0, 0),
(99, 25, 'Tá»« 1 nÄƒm trá»Ÿ lÃªn', '28', '', 0, 0, 0),
(100, 26, 'OK', '28', '', 0, 0, 0),
(101, 26, 'KhÃ´ng cung cáº¥p Ä‘Æ°á»£c', '5,19', '', 0, 0, 0),
(102, 27, 'answer.style.textAlign=''center'';\r\nappend(''Nháº¥n vÃ o nÃºt nÃ y Ä‘á»ƒ gá»­i quÃ¡ trÃ¬nh tÆ° váº¥n cá»§a báº¡n:'');\r\nvar but1=c_but1(''LÆ°u há»“ sÆ¡'');\r\nbut1.className=''saveCustomerBut'';\r\ndlg_opt({auto:1,button:but1});\r\nanswer_callback(function(){set_question_history(''Prudential'');});', '', '', 1, 0, 0),
(103, 28, 'answer.style.textAlign=''center'';\r\nappend(''Nháº¥n vÃ o nÃºt nÃ y Ä‘á»ƒ gá»­i quÃ¡ trÃ¬nh tÆ° váº¥n cá»§a báº¡n:'');\r\nvar but1=c_but1(''LÆ°u há»“ sÆ¡'');\r\nbut1.className=''saveCustomerBut'';\r\ndlg_opt({auto:1,button:but1});\r\nanswer_callback(function(){set_question_history(''VPBank'');});', '', '', 1, 0, 0),
(104, 29, 'Rá»“i', '6', '', 0, 0, 0),
(105, 29, 'ChÆ°a', '25', '', 0, 0, 0),
(106, 4, 'Từ 3 triệu trở lên ? Công ty rất lớn (có thương hiệu nổi tiếng ai cũng biết, vd: Cocacola, Vinamilk, Hoa sen Group,..), hoặc Công ty lớn (vốn điều lệ? trên 15 tỷ, thành lập trên 3 năm), hoặc Công ty nằm trong diện ưu tiên của Công ty tài chính Prudential', '12', '', 0, 0, 0),
(107, 4, 'Từ 3 triệu đến dưới 4 triệu ? Công ty khác', '15', 'Ok, lương thoả mãn', 0, 0, 0),
(108, 8, '100% vốn nước ngoài, liên doanh', '11', '', 0, 0, 0),
(109, 10, 'B', '', '', 0, 0, 0),
(110, 9, 'Cổ phần từ 9 tỷ trở lên', '12', '', 0, 0, 0),
(111, 8, 'Nhà nước', '10', '', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `vcn_customers`
--

CREATE TABLE IF NOT EXISTS `vcn_customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `birth` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `CMT` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `address` text COLLATE utf8_unicode_ci NOT NULL,
  `company` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `salary` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL,
  `post_date` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `post_time` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `last_failure` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=21 ;

--
-- Dumping data for table `vcn_customers`
--

INSERT INTO `vcn_customers` (`id`, `fullname`, `birth`, `phone`, `CMT`, `email`, `address`, `company`, `salary`, `status`, `post_date`, `post_time`, `last_failure`) VALUES
(1, 'Quach Hoang', '2012-11-14', '123456', '123324234324', 'sa@yahoo.com', 'Khu 5 Am Ha', 'A', '100000', 0, '2012-11-26', '12:33:54 pm', 0),
(2, 'PHAN ÄÃ”NG PHÃš', '2012-11-15', '123456', '1213123123', '', 'hn', 'Cong ty A', '20000000', 0, '2012-11-26', '07:32:06 am', 0),
(3, 'Quach Hoang', '2012-11-14', '123456', '123324234324', 'sa@yahoo.com', 'Khu 5 Am Ha', '', '', 0, '2012-09-11', '', 0),
(4, 'hoang', '2012-11-15', '123456789', '1213123123', 'quachhoang_2005@yahoo.com', 'hn', '', '', 0, '2012-10-20', '', 0),
(6, 'Quach Hoang', '2012-11-14', '123456', '123324234324', 'sa@yahoo.com', 'Khu 5 Am Ha', '', '', 0, '2012-09-11', '', 0),
(7, 'hoang', '2012-11-15', 'huyhoang1990', '1213123123', 'quachhoang_2005@yahoo.com', 'hn', 'ád', '234', 0, '2012-12-17', '01:37:10 am', 0),
(8, 'Quach Hoang', '2012-11-14', '123456', '123324234324', 'sa@yahoo.com', 'Khu 5 Am Ha', '', '', 0, '2012-09-11', '', 0),
(9, 'hoang', '2012-11-15', 'huyhoang1990', '1213123123', 'quachhoang_2005@yahoo.com', 'hn', '', '', 0, '2012-10-20', '', 0),
(13, 'Quach Hoang', '2012-11-14', '123456', '123324234324', 'sa@yahoo.com', 'Khu 5 Am Ha', '', '', 0, '2012-09-11', '', 0),
(14, 'hoang', '2012-11-15', 'huyhoang1990', '1213123123', 'quachhoang_2005@yahoo.com', 'hn', '', '', 0, '2012-10-20', '', 0),
(15, 'Quach Hoang', '2012-11-14', '123456', '123324234324', 'sa@yahoo.com', 'Khu 5 Am Ha', '', '', 0, '2012-09-11', '', 0),
(16, 'hoang', '2012-11-15', 'huyhoang1990', '1213123123', 'quachhoang_2005@yahoo.com', 'hn', '', '', 0, '2012-10-20', '', 0),
(17, 'Quach Hoang', '2012-11-14', '123456', '123324234324', 'sa@yahoo.com', 'Khu 5 Am Ha', '', '', 0, '2012-09-11', '', 0),
(18, 'hoang', '2012-11-15', 'huyhoang1990', '1213123123', 'quachhoang_2005@yahoo.com', 'hn', '', '', 0, '2012-10-20', '', 0),
(19, 'Quach Hoang', '2012-11-14', '123456', '123324234324', 'sa@yahoo.com', 'Khu 5 Am Ha', '', '', 0, '2012-09-11', '', 0),
(20, 'hoang', '2012-11-15', 'huyhoang1990', '1213123123', 'quachhoang_2005@yahoo.com', 'hn', '', '', 0, '2012-10-20', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `vcn_data`
--

CREATE TABLE IF NOT EXISTS `vcn_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `question` text COLLATE utf8_unicode_ci NOT NULL,
  `action` text COLLATE utf8_unicode_ci NOT NULL,
  `link_question` int(11) NOT NULL,
  `has_faq` int(11) NOT NULL,
  `default_question_css` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=31 ;

--
-- Dumping data for table `vcn_data`
--

INSERT INTO `vcn_data` (`id`, `group_title`, `question`, `action`, `link_question`, `has_faq`, `default_question_css`) VALUES
(1, '', 'Bạn có giấy tờ nào sau đây (Nếu có trên 1 loại thì vui lòng tư vấn nhiều lần để thỏa mãn nhiều sản phẩm vay khác nhau cùng lúc)', '', 0, 1, 1),
(2, '', '(A) Bạn sinh ngày tháng năm bao nhiêu?', '', 0, 1, 1),
(4, '', '(A) Mức lương hàng tháng của bạn là bao nhiêu?(Nếu chưa biết chọn đáp án nào thì hãy chọn cái gần đúng nhất, chúng tôi sẽ hỗ trợ bạn ở phần sau)', '', 0, 0, 1),
(6, '', '(A3) Chúng tôi xin lỗi. Bạn không phù hợp với sản phẩm vay nào cả. Vui lòng tham khảo lý do tại mục HỎI ĐÁP. Bạn có thể tham gia tư vấn lại hoặc cập nhật thông tin sản phẩm mới trên website www.vaycanhan.com trong vòng 1 tháng tới. Xin chân thành cảm ơn', '', 0, 0, 1),
(7, '', '(A) Tên công ty bạn đang làm việc?', '', 0, 0, 1),
(8, '', '(A) Công ty có thuộc loại hình gì?', '', 0, 0, 1),
(9, '', 'Công ty có Vốn Điều lệ bao nhiêu? \r\nGhi chú: Bạn có thể hỏi người trong Công ty hoặc tra web sau để biết thông tin này \r\nVào &lt;a href=''http://www.dpi.hochiminhcity.gov.vn/vie/webappdn/SSearch.asp?loaihinh=Dt''&gt;http://www.dpi.hochiminhcity.gov.vn/vie/webappdn/SSearch.asp?loaihinh=Dt&lt;/a&gt; rồi gõ mã số thuế Công ty vào ô Sau? GP, sau đó bấm Thực hiện để ra kết quả. Mã số thuế thường là con số có trong mộc tròn trong Hợp đồng lao đng. Những trường hợp tra không được vui lòng hỏi người trong Công ty bạn.', '', 0, 0, 1),
(10, '', 'Công ty nhà nước này là?', '', 0, 0, 1),
(11, '', 'Công ty thành lập bao lâu rồi?', '', 0, 0, 1),
(12, '', 'Bạn đang sinh sống (ngủ ban đêm) tại đâu?', '', 0, 0, 1),
(13, '', 'Bạn đang làm việc tại đâu (địa điểm công ty)?', '', 0, 0, 1),
(14, '', 'TH2: Bạn đang làm việc tại đâu (địa điểm công ty)?', '', 0, 0, 1),
(15, '', '(A1) Bạn đã hoàn thành phần câu hỏi về Công ty. Vui lòng trả lời thêm vài câu hỏi sau:\r\nNhằm giải quyết những khúc mắc không nên có và hỗ trợ khách hàng một cách tốt nhất, vui lòng cho biết bạn đã từng nộp hồ sơ vay vốn tại Ngân hàng VPBank chưa:', '', 0, 0, 1),
(16, '', '(A1) Bạn đang sinh sống (ngủ ban đêm) tại đâu?', '', 0, 0, 1),
(17, '', '(A1) Bạn đang làm việc tại đâu (địa điểm công ty)?', '', 0, 0, 1),
(18, '', '(A2) Xin chúc mừng. Bạn đủ điều kiện vay tín chấp Ngân hàng VPBank. (Kèm yêu cầu làm việc từ 1 năm trở lên) Vui lòng chuẩn bị các Giấy tờ cần thiết sau đây (Tất cả photo 1 mặt, không cần công chứng trừ Giấy xác nhận lương)\r\n&lt;ul&gt;\r\n&lt;li&gt;2 hình 3x4 có ghi rõ họ tên và Số phone phía sau&lt;/li&gt;\r\n&lt;li&gt;Bản sao CMT (không quá 15 năm kể từ ngày cấp)&lt;/li&gt;\r\n&lt;li&gt;Bản sao Hộ khẩu nguyên cuốn 16 trang kể cả trang trắng (Hộ khẩu ở đâu cũng được chấp nhận)&lt;/li&gt;\r\n&lt;li&gt;Bản sao Hợp đồng lao động, hoặc Quyết định biên chế, hoặc Quyết định Bổ nhiệm&lt;/li&gt;\r\n&lt;li&gt;Dành cho khách hàng có thời gian làm việc ghi trong Hợp đồng lao động &lt; 1 năm:\r\n&lt;ul&gt;\r\n     &lt;li&gt;Giấy xác nhận làm việc 1 năm theo mẫu tham khảo download tại đây&lt;/li&gt;\r\n     &lt;li&gt;Hoặc làm việc Công ty hiện tại trên 6 tháng và Giấy xác nhận làm việc nơi khác 1,5 năm theo mẫu tham khảo download tại đây&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;/li&gt;\r\n&lt;li&gt;Bản sao Sao kê giao dịch tài khoản ngân hàng 3 tháng gần nhất, hoặc Bảng lương 3 tháng gần nhất (mỗi tháng 1 Bảng có mộc tròn) hoặc Bản gốc Giấy xác nhận lương theo mẫu tham khảo download tại đây.&lt;/li&gt;\r\n&lt;li&gt;Bản sao chứng từ chứng minh thu nhập khác (nếu có)&lt;/li&gt;\r\n&lt;/ul&gt;\r\nVui lòng chuẩn bị hồ sơ, rồi gọi MR.HUY 0944.0499.10 (�?��? xác nhận hồ sơ) và gửi h��? sơ trực tiếp hoặc chuy��?n phát nhanh theo �?��?a ch��? Nguy��?n Thu Trang B112/14 (s��? cũ trên bi��?n s��? nhà là 114/3) Bạch Đằng, phường 2, quận Tân Bình, Tp.HCM (cách sân bay Tân Sơn Nhất 200m). \r\nLãi suất từ 1.3% �?ến 2.95% m��?t tháng. Thời gian giải ngân từ 7-10 ngày k��? từ khi h��? sơ �?ầy �?ủ. Bạn vui lòng chuẩn b��? �?ầy �?ủ �?��? �?ược giải ngân trong thời gian s��?m nhất\r\nMọi thắc mắc xin xem chi tiết tại mục H��?I ĐÁP\r\nMọi chi tiết khác vui lòng gọi Trang 0944.0499.10 (�?��? �?ảm bảo chất lượng phục vụ t��?t nhất, vui lòng tham gia tư vấn trực tuyến trư��?c khi gọi)', '', 0, 0, 0),
(19, '', 'Báº¡n Ä‘Ã£ hoÃ n thÃ nh pháº§n cÃ¢u há»i vá» CÃ´ng ty. Vui lÃ²ng tráº£ lá»i thÃªm vÃ i cÃ¢u há»i sau:\r\n(A4) Nháº±m giáº£i quyáº¿t nhá»¯ng khÃºc máº¯c khÃ´ng nÃªn cÃ³ vÃ  há»— trá»£ khÃ¡ch hÃ ng má»™t cÃ¡ch tá»‘i Ä‘a, vui lÃ²ng cho biáº¿t báº¡n Ä‘Ã£ tá»«ng ná»™p há»“ sÆ¡ vay vá»‘n táº¡i CÃ´ng ty tÃ i chÃ­nh Prudential chÆ°a:', '', 0, 0, 1),
(20, '', '(A4) Náº¿u KH trÃªn 25 tuá»•i, TÃ­nh Ä‘áº¿n ngÃ y hÃ´m nay, báº¡n Ä‘Ã£ lÃ m viá»‡c táº¡i CÃ´ng ty bao lÃ¢u? (ká»ƒ cáº£ thá»­ viá»‡c)', '', 0, 0, 1),
(21, '', '(A4) HÃ¬nh thá»©c tráº£ lÆ°Æ¡ng cá»§a báº¡n lÃ :', '', 0, 0, 1),
(22, '', '(A4) Náº¿u KH tá»« 21-25 tuá»•i. TÃ­nh Ä‘áº¿n ngÃ y hÃ´m nay, báº¡n Ä‘Ã£ lÃ m viá»‡c táº¡i CÃ´ng ty bao lÃ¢u? (ká»ƒ cáº£ thá»­ viá»‡c)', '', 0, 0, 1),
(23, '', '(A4) CÃ¢u há»i nháº¥n máº¡nh láº¡i: Má»©c lÆ°Æ¡ng hÃ ng thÃ¡ng cá»§a báº¡n lÃ ?', '', 0, 0, 1),
(24, '', 'Vá»›i má»©c lÆ°Æ¡ng nÃ y, báº¡n vui lÃ²ng nháº¯n tin mÃ£ sá»‘ thuáº¿ CÃ´ng ty Ä‘á»ƒ chÃºng tÃ´i kiá»ƒm tra (khoáº£ng 1 ngÃ y) xem báº¡n cÃ³ Ä‘á»§ Ä‘iá»u kiá»‡n vay bÃªn Prudential hay khÃ´ng? (LÆ°u Ã½ lÃ  dá»±a vÃ o nhá»¯ng cÃ¢u tráº£ lá»i trÃªn thÃ¬ chá»‰ cÃ³ CÃ´ng ty tÃ i chÃ­nh Prudential lÃ  cÃ³ thá»ƒ phÃ¹ há»£p vá»›i báº¡n)\r\nCÃº phÃ¡p Há» tÃªn _ Prudential _  MÃ£ sá»‘ thuáº¿ gá»­i 0944.0499.10', '', 0, 0, 1),
(25, '', '(A5) TÃ­nh Ä‘áº¿n ngÃ y hÃ´m nay, báº¡n Ä‘Ã£ lÃ m viá»‡c táº¡i CÃ´ng ty bao lÃ¢u? (ká»ƒ cáº£ thá»­ viá»‡c)', '', 0, 0, 1),
(26, '', '(A5) Báº¡n vui lÃ²ng cung cáº¥p giáº¥y xÃ¡c nháº­n thá»i gian CÃ´ng tÃ¡c trÃªn 1 nÄƒm (sáº½ cÃ³ lá»£i hÆ¡n cho báº¡n khi vay)?', '', 0, 0, 1),
(27, '', '(A6) Xin chÃºc má»«ng. Báº¡n Ä‘á»§ Ä‘iá»u kiá»‡n Ä‘á»ƒ vay tÃ­n cháº¥p CÃ´ng ty tÃ i chÃ­nh Prudential. (KÃ¨m theo yÃªu cáº§u cÃ³ Há»™ kháº©u hoáº·c KT3 táº¡i nÆ¡i cÆ° trÃº) Vui lÃ²ng chuáº©n bá»‹ cÃ¡c Giáº¥y tá» cáº§n thiáº¿t sau Ä‘Ã¢y (Táº¥t cáº£ photo má»™t máº·t, khÃ´ng cáº§n cÃ´ng chá»©ng)\r\nï‚§	CMND\r\nï‚§	Báº£o hiá»ƒm y táº¿\r\nï‚§	1 Giáº¥y tá» khÃ¡c cÃ³ hÃ¬nh (báº±ng lÃ¡i xe/ há»™ chiáº¿u/ tháº» nhÃ¢n viÃªn/ báº±ng tá»‘t nghiá»‡p ÄH hoáº·c CÄ/ Trung cáº¥pâ€¦.). Chá»‰ cáº§n 1 trong cÃ¡c loáº¡i nÃªu trong ngoáº·c.\r\nï‚§	Há»™ kháº©u hoáº·c KT3 táº¡i nÆ¡i cÆ° trÃº gá»“m TP.HCM, BÃ¬nh DÆ°Æ¡ng, Äá»“ng Nai, Long An, HÃ  Ná»™i.\r\nï‚§	1 HÃ³a Ä‘Æ¡n (Ä‘iá»‡n/ nÆ°á»›c/ Ä‘iá»‡n thoáº¡i bÃ n/ internet/ truyá»n hÃ¬nh cÃ¡p) thÃ¡ng gáº§n nháº¥t Táº I NÆ I ÄANG CÆ¯ TRÃš. Chá»‰ cáº§n 1 trong cÃ¡c loáº¡i hÃ³a Ä‘Æ¡n ghi trong ngoáº·c.\r\nï‚§	Há»£p Ä‘á»“ng lao Ä‘á»™ng hoáº·c Quyáº¿t Ä‘á»‹nh biÃªn cháº¿, hoáº·c Quyáº¿t Ä‘á»‹nh Bá»• nhiá»‡m\r\nï‚§	DÃ nh cho khÃ¡ch hÃ ng cÃ³ thá»i gian lÃ m viá»‡c trong Há»£p Ä‘á»“ng lao Ä‘á»™ng hiá»‡n hÃ nh chÆ°a Ä‘á»§ \r\nï‚§	Tá»« 21 Ä‘áº¿n dÆ°á»›i 25 tuá»•i: Há»£p Ä‘á»“ng lao Ä‘á»™ng cÅ© Hoáº·c Giáº¥y xÃ¡c nháº­n lÃ m viá»‡c 1 nÄƒm theo máº«u tham kháº£o download táº¡i Ä‘Ã¢y Hoáº·c Giáº¥y xÃ¡c nháº­n lÃ m viá»‡c CÃ´ng ty hiá»‡n táº¡i trÃªn 6 thÃ¡ng vÃ  Giáº¥y xÃ¡c nháº­n lÃ m viá»‡c CÃ´ng ty trÆ°á»›c Ä‘Ã³ 2 nÄƒm theo máº«u tham kháº£o download táº¡i Ä‘Ã¢y\r\nï‚§	Tá»« 25 tuá»•i trá»Ÿ lÃªn: Giáº¥y xÃ¡c nháº­n lÃ m viá»‡c 3 thÃ¡ng theo máº«u tham kháº£o download táº¡i Ä‘Ã¢y\r\nï‚§	Báº£n sao Sao kÃª giao dá»‹ch tÃ i khoáº£n ngÃ¢n hÃ ng 3 thÃ¡ng gáº§n nháº¥t, hoáº·c Báº£ng lÆ°Æ¡ng 3 thÃ¡ng gáº§n nháº¥t (má»—i thÃ¡ng 1 Báº£ng cÃ³ má»™c trÃ²n) hoáº·c Báº£n gá»‘c Giáº¥y xÃ¡c nháº­n lÆ°Æ¡ng theo máº«u tham kháº£o download táº¡i Ä‘Ã¢y.\r\nï‚§	ThÃ´ng tin bá»• sung: chÃºng tÃ´i sáº½ Æ°u tiÃªn vá» lÃ£i suáº¥t cho khÃ¡ch hÃ ng nÃ o cÃ³ Tháº» tÃ­n dá»¥ng (háº¡n má»©c tá»« 15 triá»‡u trá»Ÿ lÃªn) HOáº¶C Báº£o hiá»ƒm nhÃ¢n thá» (thá»i gian sá»­ dá»¥ng tá»« 6 thÃ¡ng trá»Ÿ lÃªn)\r\n\r\nVui lÃ²ng chuáº©n bá»‹ há»“ sÆ¡, rá»“i gá»i Trang 0944.0499.10(Ä‘á»ƒ xÃ¡c nháº­n há»“ sÆ¡) vÃ  gá»­i há»“ sÆ¡ trá»±c tiáº¿p hoáº·c chuyá»ƒn phÃ¡t nhanh theo Ä‘á»‹a chá»‰ Nguyá»…n Thu Trang B112/14 (sá»‘ cÅ© trÃªn biá»ƒn sá»‘ nhÃ  lÃ  114/3) Báº¡ch Äáº±ng, phÆ°á»ng 2, quáº­n TÃ¢n BÃ¬nh, Tp.HCM (cÃ¡ch sÃ¢n bay TÃ¢n SÆ¡n Nháº¥t 200m). \r\nLÃ£i suáº¥t tá»« 1.3% Ä‘áº¿n 1.9% má»™t thÃ¡ng. Thá»i gian giáº£i ngÃ¢n tá»« 3-5 ngÃ y ká»ƒ tá»« khi há»“ sÆ¡ Ä‘áº§y Ä‘á»§. Báº¡n vui lÃ²ng chuáº©n bá»‹ Ä‘áº§y Ä‘á»§ Ä‘á»ƒ Ä‘Æ°á»£c giáº£i ngÃ¢n trong thá»i gian sá»›m nháº¥t\r\nMá»i tháº¯c máº¯c xin xem chi tiáº¿t táº¡i má»¥c Há»ŽI ÄÃP\r\nMá»i chi tiáº¿t khÃ¡c vui lÃ²ng gá»i Trang 0944.0499.10 (Ä‘á»ƒ Ä‘áº£m báº£o cháº¥t lÆ°á»£ng phá»¥c vá»¥ tá»‘t nháº¥t, vui lÃ²ng tham gia tÆ° váº¥n trá»±c tuyáº¿n trÆ°á»›c khi gá»i)', '', 0, 0, 1),
(28, '', '(A7) Xin chÃºc má»«ng. Báº¡n Ä‘á»§ Ä‘iá»u kiá»‡n Ä‘á»ƒ vay tÃ­n cháº¥p CÃ´ng ty tÃ i chÃ­nh Prudential vÃ  VPBank. Báº¡n cÃ³ thá»ƒ chá»n 1 trong 2. (Prudential kÃ¨m theo yÃªu cáº§u cÃ³ Há»™ kháº©u hoáº·c KT3 táº¡i nÆ¡i cÆ° trÃº) Vui lÃ²ng chuáº©n bá»‹ cÃ¡c Giáº¥y tá» cáº§n thiáº¿t sau Ä‘Ã¢y (Táº¥t cáº£ photo má»™t máº·t, khÃ´ng cáº§n cÃ´ng chá»©ng)\r\nï‚§	2 hÃ¬nh 3 x 4\r\nï‚§	CMND\r\nï‚§	Báº£o hiá»ƒm y táº¿\r\nï‚§	1 Giáº¥y tá» khÃ¡c cÃ³ hÃ¬nh (báº±ng lÃ¡i xe/ há»™ chiáº¿u/ tháº» nhÃ¢n viÃªn/ báº±ng tá»‘t nghiá»‡p ÄH hoáº·c CÄ/ Trung cáº¥pâ€¦.). Chá»‰ cáº§n 1 trong cÃ¡c loáº¡i nÃªu trong ngoáº·c.\r\nï‚§	Há»™ kháº©u hoáº·c KT3 táº¡i nÆ¡i cÆ° trÃº gá»“m TP.HCM, BÃ¬nh DÆ°Æ¡ng, Äá»“ng Nai, Long An, HÃ  Ná»™i.\r\nï‚§	1 HÃ³a Ä‘Æ¡n (Ä‘iá»‡n/ nÆ°á»›c/ Ä‘iá»‡n thoáº¡i bÃ n/ internet/ truyá»n hÃ¬nh cÃ¡p) thÃ¡ng gáº§n nháº¥t Táº I NÆ I ÄANG CÆ¯ TRÃš. Chá»‰ cáº§n 1 trong cÃ¡c loáº¡i hÃ³a Ä‘Æ¡n ghi trong ngoáº·c.\r\nï‚§	Há»£p Ä‘á»“ng lao Ä‘á»™ng hoáº·c Quyáº¿t Ä‘á»‹nh biÃªn cháº¿, hoáº·c Quyáº¿t Ä‘á»‹nh Bá»• nhiá»‡m\r\nï‚§	DÃ nh cho khÃ¡ch hÃ ng cÃ³ thá»i gian lÃ m viá»‡c trong Há»£p Ä‘á»“ng lao Ä‘á»™ng hiá»‡n hÃ nh chÆ°a Ä‘á»§ \r\nï‚§	(Náº¿u cáº§n tÃ¹y khÃ¡ch hÃ ng) Giáº¥y xÃ¡c nháº­n lÃ m viá»‡c trÃªn 1 nÄƒm theo máº«u tham kháº£o download táº¡i Ä‘Ã¢y\r\nï‚§	Báº£n sao Sao kÃª giao dá»‹ch tÃ i khoáº£n ngÃ¢n hÃ ng 3 thÃ¡ng gáº§n nháº¥t, hoáº·c Báº£ng lÆ°Æ¡ng 3 thÃ¡ng gáº§n nháº¥t (má»—i thÃ¡ng 1 Báº£ng cÃ³ má»™c trÃ²n) hoáº·c Báº£n gá»‘c Giáº¥y xÃ¡c nháº­n lÆ°Æ¡ng theo máº«u tham kháº£o download táº¡i Ä‘Ã¢y.\r\nï‚§	ThÃ´ng tin bá»• sung: chÃºng tÃ´i sáº½ Æ°u tiÃªn vá» lÃ£i suáº¥t cho khÃ¡ch hÃ ng nÃ o cÃ³ Tháº» tÃ­n dá»¥ng (háº¡n má»©c tá»« 15 triá»‡u trá»Ÿ lÃªn) HOáº¶C Báº£o hiá»ƒm nhÃ¢n thá» (thá»i gian sá»­ dá»¥ng tá»« 6 thÃ¡ng trá»Ÿ lÃªn)\r\n\r\nVui lÃ²ng chuáº©n bá»‹ há»“ sÆ¡, rá»“i gá»i Trang 0944.0499.10 (Ä‘á»ƒ xÃ¡c nháº­n há»“ sÆ¡) vÃ  gá»­i há»“ sÆ¡ trá»±c tiáº¿p hoáº·c chuyá»ƒn phÃ¡t nhanh theo Ä‘á»‹a chá»‰ Nguyá»…n Thu Trang B112/14 (sá»‘ cÅ© trÃªn biá»ƒn sá»‘ nhÃ  lÃ  114/3) Báº¡ch Äáº±ng, phÆ°á»ng 2, quáº­n TÃ¢n BÃ¬nh, Tp.HCM (cÃ¡ch sÃ¢n bay TÃ¢n SÆ¡n Nháº¥t 200m). \r\nLÃ£i suáº¥t tá»« 1.3% Ä‘áº¿n 2.95% má»™t thÃ¡ng. Thá»i gian giáº£i ngÃ¢n tá»« 3-10 ngÃ y ká»ƒ tá»« khi há»“ sÆ¡ Ä‘áº§y Ä‘á»§. Báº¡n vui lÃ²ng chuáº©n bá»‹ Ä‘áº§y Ä‘á»§ Ä‘á»ƒ Ä‘Æ°á»£c giáº£i ngÃ¢n trong thá»i gian sá»›m nháº¥t\r\nMá»i tháº¯c máº¯c xin xem chi tiáº¿t táº¡i má»¥c Há»ŽI ÄÃP\r\nMá»i chi tiáº¿t khÃ¡c vui lÃ²ng gá»i Trang 0944.0499.10 (Ä‘á»ƒ Ä‘áº£m báº£o cháº¥t lÆ°á»£ng phá»¥c vá»¥ tá»‘t nháº¥t, vui lÃ²ng tham gia tÆ° váº¥n trá»±c tuyáº¿n trÆ°á»›c khi gá»i)', '', 0, 0, 1),
(29, '', '(A5) Nháº±m giáº£i quyáº¿t nhá»¯ng khÃºc máº¯c khÃ´ng nÃªn cÃ³ vÃ  há»— trá»£ khÃ¡ch hÃ ng má»™t cÃ¡ch tá»‘i Ä‘a, vui lÃ²ng cho biáº¿t báº¡n Ä‘Ã£ tá»«ng ná»™p há»“ sÆ¡ vay vá»‘n táº¡i CÃ´ng ty tÃ i chÃ­nh Prudential chÆ°a:', '', 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `vcn_faq`
--

CREATE TABLE IF NOT EXISTS `vcn_faq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_` int(11) NOT NULL,
  `faq` text COLLATE utf8_unicode_ci NOT NULL,
  `answer` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Dumping data for table `vcn_faq`
--

INSERT INTO `vcn_faq` (`id`, `group_`, `faq`, `answer`) VALUES
(1, 1, 'CÃ¡ch Ä‘á»‹nh dáº¡ng ngÃ y', 'Sá»­ dá»¥ng Ä‘á»‹nh dáº¡ng d-m-y. VÃ­ dá»¥: 09/04/1990'),
(2, 2, 'Nhap ngay sinh de tinh tuoi', 'vi du: 09/04/1990'),
(4, 1, 'dsfdsfnsdf', 'ksdnffksfsdf'),
(8, 4, 'A', 'a'),
(9, 7, 'ten cong ty', 'A'),
(10, 0, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `vcn_histories`
--

CREATE TABLE IF NOT EXISTS `vcn_histories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `company` varchar(100) NOT NULL,
  `salary` varchar(100) NOT NULL,
  `save_history` text NOT NULL,
  `result` int(11) NOT NULL,
  `post_date` varchar(100) NOT NULL,
  `post_time` varchar(100) NOT NULL,
  `loan` varchar(200) NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=100 ;

--
-- Dumping data for table `vcn_histories`
--

INSERT INTO `vcn_histories` (`id`, `customer_id`, `company`, `salary`, `save_history`, `result`, `post_date`, `post_time`, `loan`, `note`) VALUES
(1, 1, '', '', '1', 1, '2012-11-24', '', '', ''),
(2, 1, '', '', '1-1,2-6,4-9', 0, '2012-11-21', '', '', ''),
(3, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-11', '', '', ''),
(4, 1, '', '', '1', 1, '2012-11-24', '', '', ''),
(5, 1, '', '', '1-1,2-0,4-9', 0, '2012-11-21', '', '', ''),
(6, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-11', '', '', ''),
(7, 1, '', '', '1', 1, '2012-11-24', '', '', ''),
(8, 1, '', '', '1-1,2-0,4-9', 0, '2012-11-21', '', '', ''),
(9, 2, '', '', '1-1,2-0,4-9', 1, '2012-11-11', '', '', ''),
(10, 1, '', '', '1', 0, '2012-11-24', '', '', ''),
(11, 1, '', '', '1-1,2-0,4-9', 0, '2012-11-21', '', '', ''),
(12, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-11', '', '', ''),
(14, 1, '', '', '1', 0, '2012-11-24', '', '', ''),
(15, 1, '', '', '1-1,2-0,4-9', 0, '2012-11-21', '', '', ''),
(16, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-11', '', '', ''),
(17, 1, '', '', '1', 0, '2012-11-24', '', '', ''),
(18, 1, '', '', '1-1,2-0,4-9', 0, '2012-11-21', '', '', ''),
(19, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-11', '', '', ''),
(20, 1, '', '', '1', 0, '2012-11-24', '', '', ''),
(21, 1, '', '', '1-1,2-0,4-9', 0, '2012-11-21', '', '', ''),
(22, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-11', '', '', ''),
(23, 1, '', '', '1', 0, '2012-11-24', '', '', ''),
(24, 1, '', '', '1-1,2-0,4-9', 0, '2012-11-21', '', '', ''),
(25, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-11', '', '', ''),
(29, 1, '', '', '1', 0, '2012-11-24', '', '', ''),
(30, 1, '', '', '1-1,2-0,4-9', 0, '2012-11-21', '', '', ''),
(31, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-11', '', '', ''),
(32, 1, '', '', '1', 0, '2012-11-24', '', '', ''),
(33, 1, '', '', '1-1,2-0,4-9', 0, '2012-11-21', '', '', ''),
(34, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-11', '', '', ''),
(35, 1, '', '', '1', 0, '2012-11-24', '', '', ''),
(36, 1, '', '', '1-1,2-0,4-9', 0, '2012-11-21', '', '', ''),
(37, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-11', '', '', ''),
(38, 1, '', '', '1', 0, '2012-11-24', '', '', ''),
(39, 1, '', '', '1-1,2-0,4-9', 0, '2012-11-21', '', '', ''),
(40, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-11', '', '', ''),
(41, 1, '', '', '1', 0, '2012-11-24', '', '', ''),
(42, 1, '', '', '1-1,2-0,4-9', 0, '2012-11-21', '', '', ''),
(43, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-11', '', '', ''),
(44, 1, '', '', '1', 0, '2012-11-24', '', '', ''),
(45, 1, '', '', '1-1,2-0,4-9', 0, '2012-11-21', '', '', ''),
(46, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-11', '', '', ''),
(47, 1, '', '', '1', 0, '2012-11-24', '', '', ''),
(48, 1, '', '', '1-1,2-0,4-9', 0, '2012-11-21', '', '', ''),
(49, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-11', '', '', ''),
(50, 1, '', '', '1', 0, '2012-11-24', '', '', ''),
(51, 1, '', '', '1-1,2-0,4-9', 0, '2012-11-21', '', '', ''),
(52, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-11', '', '', ''),
(60, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-24', '', '', ''),
(61, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-24', '', '', ''),
(62, 2, '', '', '1-1,2-0,4-9', 0, '2012-11-24', '', '', ''),
(63, 2, '', '', '1-1,2-6,4-9', 0, '2012-11-24', '', '', ''),
(64, 1, '', '', '1-1,2-6,4-9', 0, '2012-11-24', '', '', ''),
(65, 1, '', '', '1-1,2-6,4-9', 0, '2012-11-24', '', '', ''),
(66, 1, '', '', '1-1,2-6,4-9', 0, '2012-11-24', '', '', ''),
(67, 1, '', '', '1-1,2-6,4-9', 0, '2012-11-24', '', '', ''),
(68, 2, '', '', '1-1,2-6,4-9', 0, '2012-11-24', '', '', ''),
(69, 1, '', '', '1-1,2-6,4-9', 0, '2012-11-24', '', '', ''),
(70, 2, '', '', '1-1,2-6,4-9', 0, '2012-11-24', '', '', ''),
(71, 1, '', '', '1-1,2-6,4-9', 0, '2012-11-24', '', '', ''),
(72, 1, '', '', '1-1,2-6,4-9', 0, '2012-11-24', '', '', ''),
(73, 1, '', '', '1-1,2-6,4-9', 0, '2012-11-24', '', '', ''),
(74, 1, '', '', '1-1,2-6,4-9', 0, '2012-11-24', '', '', ''),
(75, 1, '', '', '1-1,2-6,4-9', 0, '2012-11-24', '', '', ''),
(76, 1, '', '', '1-1,2-6,4-9', 0, '2012-11-24', '', '', ''),
(77, 1, '', '', '1-1,2-6,4-9', 0, '2012-11-25', '02:19:26 am', '', ''),
(78, 2, '', '', '1-1,2-6,6-12', 0, '2012-11-25', '07:23:41 am', '', ''),
(79, 2, '', '', '1-1,2-6,4-9,6-12', 0, '2012-11-25', '07:25:48 am', '', ''),
(80, 2, '', '', '1-1,2-6,4-9,6-12', 0, '2012-11-25', '07:36:00 am', '', ''),
(81, 2, '', '', '1-1,2-6,4-9,6-12', 0, '2012-11-25', '07:38:15 am', '', ''),
(82, 2, '', '', '1-1,2-6,4-9,6-12', 0, '2012-11-25', '08:43:53 am', 'sdkjfdskfdksfsdf', ''),
(83, 2, '', '', '1-1,2-6,4-9', 0, '2012-11-25', '10:34:05 am', '23fefdsfdsfdsf', ''),
(84, 2, '', '', '1-1,2-6,4-10,6-12,15-65,16-66,17-75', 0, '2012-11-25', '10:39:52 am', 'vay 30 tr', ''),
(85, 2, '', '', '1-1,2-6,4-10,15-65,16-66,17-75', 0, '2012-11-25', '11:22:47 am', 'hoa hong', ''),
(86, 2, '', '', '1-1,2-6,4-10,6-12,15-65,16-70,17-75,18-84', 0, '2012-11-25', '11:29:37 am', 'huyhoang', ''),
(87, 2, '', '', '1-1,2-6,4-9,6-12,15-65', 65, '2012-11-25', '11:49:09 am', 'dlskfnkddgdf', ''),
(88, 2, '', '', '1-1,2-6,4-10,15-65,16-68,17-79,18-84', 84, '2012-11-25', '11:55:38 am', '5', ''),
(89, 2, '', '', '1-1,2-6,4-106,6-12,12-28,14-58', 1, '2012-11-25', '16:08:35 pm', 'rtrtrtt', ''),
(96, 2, 'A', '24', '1-1,2-6,4-10,15-65,16-66,17-75,18-84', 84, '2012-11-25', '17:02:22 pm', '3rfsfd', ''),
(97, 2, 'sadsf', '565767868', '1-1,2-6,4-10,15-65,16-66,17-75,18-84', 84, '2012-11-25', '17:03:55 pm', 'gddgdfgdfgd', ''),
(98, 2, 'dasdfsdf', '3546457', '1-1,2-6,4-107,15-65,16-72,17-81,18-84', 84, '2012-11-25', '17:05:10 pm', 'yrhfhfhg', ''),
(99, 7, 'ád', '234', '1-1,2-6,4-9,6-12', 12, '2012-12-24', '14:27:34 pm', '343', 'M?c ?ích s? d?ng:\r\n5sfdsfdsf\r\n,Th?i gian chúng tôi liên h?:8h - 11h');

-- --------------------------------------------------------

--
-- Table structure for table `vcn_histories1`
--

CREATE TABLE IF NOT EXISTS `vcn_histories1` (
  `hid` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `answer_text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vcn_histories1`
--

INSERT INTO `vcn_histories1` (`hid`, `answer_id`, `answer_text`) VALUES
(75, 6, '1986-06-21'),
(76, 6, '1986-06-24'),
(77, 6, '1986-06-18'),
(78, 6, '1995-06-29'),
(79, 6, '1986-06-26'),
(79, 12, 'No_answer'),
(80, 6, '1986-06-20'),
(80, 12, 'X'),
(81, 6, '1986-06-27'),
(81, 12, 'A'),
(82, 6, '1986-06-18'),
(82, 12, 'X'),
(83, 6, '1986-06-18'),
(84, 6, '1986-06-19'),
(84, 12, 'X'),
(85, 6, '1986-06-25'),
(86, 6, '1986-06-25'),
(86, 12, 'X'),
(86, 84, 'X'),
(87, 6, '1986-06-30'),
(87, 12, 'X'),
(88, 6, '1986-06-25'),
(88, 84, 'VPBank'),
(89, 6, '1986-06-04'),
(89, 12, 'X'),
(90, 6, '1986-06-18'),
(90, 84, 'X'),
(91, 6, '1986-06-04'),
(91, 12, 'X'),
(92, 6, '1986-06-18'),
(92, 12, 'X'),
(93, 6, '1986-06-11'),
(93, 84, 'X'),
(94, 6, '1986-06-25'),
(94, 12, 'X'),
(95, 6, '1986-06-25'),
(95, 84, 'VPBank'),
(96, 6, '1986-06-26'),
(96, 84, 'VPBank'),
(97, 6, '1986-06-10'),
(97, 84, 'VPBank'),
(98, 6, '1985-06-12'),
(98, 84, 'VPBank'),
(99, 6, '1986-06-18'),
(99, 6, '1986-06-26'),
(99, 12, 'X');

-- --------------------------------------------------------

--
-- Table structure for table `vcn_news`
--

CREATE TABLE IF NOT EXISTS `vcn_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `post_time` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `type_` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `vcn_news`
--

INSERT INTO `vcn_news` (`id`, `title`, `body`, `post_time`, `type_`, `status`) VALUES
(1, 'ThÃ´ng bÃ¡o: Thay Ä‘á»•i vá» quáº£n lÃ½ tÃ i khoáº£n vá»›i cÃ¡c giao dá»‹ch liÃªn quan Ä‘áº¿n tháº» cÃ o Ä‘iá»‡n thoáº¡i', 'NhÆ° thÃ´ng bÃ¡o ngÃ y 7.5.2012 cá»§a Báº£o Kim vá» viá»‡c gia háº¡n rÃºt tiá»n vá»›i cÃ¡c giao dá»‹ch liÃªn quan Ä‘áº¿n  tháº» cÃ o\r\nTá»« ngÃ y 10.5. 2012, tiá»n cá»§a cÃ¡c giao dá»‹ch liÃªn quan Ä‘áº¿n tháº» cÃ o sáº½ Ä‘Æ°á»£c Báº£o Kim táº¡m giá»¯ Ä‘á»ƒ Ä‘á»‘i soÃ¡t vá»›i cÃ¡c nhÃ  máº¡ng.Sá»‘ tiá»n nÃ y Ä‘Æ°á»£c lÆ°u á»Ÿ tÃ i khoáº£n Ä‘Ã³ng bÄƒng, khÃ´ng vá» sá»‘ dÆ° kháº£ dá»¥ng. Äáº¿n thá»i háº¡n rÃºt tiá»n, há»‡ thá»‘ng sáº½ tá»± Ä‘á»™ng giáº£i bÄƒng, tiá»n sáº½ vá» sá»‘ dÆ° kháº£ dá»¥ng Ä‘á»ƒ khÃ¡ch hÃ ng rÃºt tiá»n.\r\n \r\nQuÃ½ khÃ¡ch vui lÃ²ng xem chi tiáº¿t táº¡i Ä‘Ã¢y\r\n \r\nTrÃ¢n trá»ng thÃ´ng bÃ¡o!\r\nBQT Báº£o Kim', '2012-11-26', '0', 1),
(2, 'ThÃ´ng bÃ¡o chÃ­nh thá»©c ra máº¯t dá»‹ch vá»¥ má»›i.', 'Siki.vn â€“ khai thÃ¡c máº¡ng xÃ£ há»™i Ä‘á»ƒ kinh doanh trá»±c tuyáº¿n.\r\nTá»« thÃ¡ng 6/2012, CÃ´ng ty Cá»• pháº§n ThÆ°Æ¡ng máº¡i Äiá»‡n tá»­ Báº£o Kim (Báº£o Kim) chÃ­nh thá»©c triá»ƒn khai há»‡ thá»‘ng kinh doanh trá»±c tuyáº¿n má»›i cÃ³ kháº£ nÄƒng khai thÃ¡c tá»‘i Ä‘a sá»©c máº¡nh tá»« cÃ¡c máº¡ng xÃ£ há»™i hiá»‡n cÃ³ vá»›i tÃªn gá»i Siki (siki.vn) káº¿t há»£p vá»›i tÃ­nh nÄƒng thanh toÃ¡n Æ°u viá»‡t, tiá»‡n lá»£i cá»§a vÃ­ Ä‘iá»‡n tá»­ hÃ ng Ä‘áº§u Báº£o Kim.\r\nSiki Ä‘Æ°á»£c xÃ¢y dá»±ng trÃªn cÆ¡ sá»Ÿ tham kháº£o mÃ´ hÃ¬nh cá»§a Gumroad.com â€“ má»™t hiá»‡n tÆ°á»£ng Ä‘ang gÃ¢y chÃº Ã½ cá»§a nhiá»u nhÃ  Ä‘áº§u tÆ° tÃªn tuá»•i trÃªn tháº¿ giá»›i thá»i gian qua. Siki.vn cÅ©ng chÃ­nh lÃ  á»©ng dá»¥ng trá»±c tuyáº¿n Ä‘áº§u tiÃªn táº¡i Viá»‡t Nam khai thÃ¡c sá»©c máº¡nh cá»§a mÃ´ hÃ¬nh nÃ y.\r\n \r\nHiá»‡n nay, thÆ°Æ¡ng máº¡i Ä‘iá»‡n tá»­ (TMÄT) Ä‘Ã£ kháº³ng Ä‘á»‹nh Ä‘Æ°á»£c vai trÃ² cá»§a mÃ¬nh trong cÃ¡c hoáº¡t Ä‘á»™ng giao thÆ°Æ¡ng. Nhiá»u mÃ´ hÃ¬nh kinh doanh trá»±c tuyáº¿n Ä‘Ã£ Ä‘Æ°á»£c triá»ƒn khai vÃ  Ä‘Ã£ Ä‘Ã³ng gÃ³p khÃ´ng nhá» tá»›i hoáº¡t Ä‘á»™ng kinh doanh cá»§a nhiá»u cÃ¡ nhÃ¢n, doanh nghiá»‡p. Tuy nhiÃªn, ráº¥t dá»… nháº­n tháº¥y lÃ  mÃ´ hÃ¬nh cÃ¡c sÃ n hiá»‡n táº¡i chÆ°a thá»±c sá»± há»— trá»£ nhiá»u cho ngÆ°á»i dÃ¹ng trong viá»‡c tÆ°Æ¡ng tÃ¡c vá»›i cÃ¡c máº¡ng xÃ£ há»™i, má»™t thá»‹ trÆ°á»ng tiá»m nÄƒng cÃ²n bá» ngá».\r\n\r\nMÃ´ hÃ¬nh kinh doanh má»›i, táº­n dá»¥ng tá»‘i Ä‘a sá»©c máº¡nh máº¡ng xÃ£ há»™i Ä‘Ã£ cÃ³ máº·t táº¡i Viá»‡t Nam\r\nÃ tÆ°á»Ÿng ra Ä‘á»i cá»§a Siki cÅ©ng tÆ°Æ¡ng Ä‘á»‘i Ä‘Æ¡n giáº£n nhÆ°ng khai thÃ¡c triá»‡t Ä‘á»ƒ lá»£i Ã­ch tá»« cÃ¡c máº¡ng xÃ£ há»™i hiá»‡n cÃ³, mang láº¡i khÃ¡i niá»‡m má»›i vá» kinh doanh trá»±c tuyáº¿n thÃ´ng qua tÆ°Æ¡ng tÃ¡c cá»§a cÃ¡c máº¡ng xÃ£ há»™i. Má»¥c tiÃªu cá»§a Siki lÃ  phá»¥c vá»¥ tá»‘i Ä‘a nhu cáº§u mua/bÃ¡n vá»›i tiÃªu chÃ­ Ä‘Æ¡n giáº£n nháº¥t (trong hoáº¡t Ä‘á»™ng kinh doanh), thuáº­n tiá»‡n (trong quáº£ng cÃ¡o) vÃ  dá»… dÃ ng (trong thanh toÃ¡n)\r\n.\r\n\r\nQuy trÃ¬nh hoáº¡t Ä‘á»™ng cá»§a Siki ráº¥t Ä‘Æ¡n giáº£n cho táº¥t cáº£ má»i Ä‘á»‘i tÆ°á»£ng\r\nVá»›i Siki.vn, báº¥t cá»© ai cÅ©ng cÃ³ thá»ƒ dá»… dÃ ng Ä‘Äƒng bÃ¡n hay tÃ¬m mua sáº£n pháº©m mÃ¬nh cáº§n cho cÃ¡c thÃ nh viÃªn cá»§a cÃ¡c máº¡ng xÃ£ há»™i thÃ´ng qua duy nháº¥t 01 Ä‘Æ°á»ng link liÃªn káº¿t. Hiá»‡n Siki Ä‘ang há»— trá»£ cÃ¡c máº¡ng Facebook, Twitter, Googl+ vÃ  ZingMe. Trong thá»i gian tá»›i, Siki sáº½ tiáº¿p tá»¥c má»Ÿ rá»™ng máº¡ng lÆ°á»›i máº¡ng xÃ£ há»™i trong nÆ°á»›c Ä‘á»ƒ tÄƒng Ä‘á»™ phá»§ vÃ  hiá»‡u quáº£ cho ngÆ°á»i dÃ¹ng.\r\n\r\nÄÆ¡n giáº£n vá»›i 01 link duy nháº¥t, ai cÅ©ng cÃ³ thá»ƒ kinh doanh\r\nNáº¿u nhÆ° Gumroad chá»‰ cho chia sáº» link bÃ¡n thÃ¬ Siki.vn há»— trá»£ 3 dáº¡ng link vá»›i 3 má»¥c tiÃªu khÃ¡c nhau: link bÃ¡n, link mua vÃ  Ä‘áº·c biá»‡t lÃ  buÃ´n link. Äiá»u nÃ y cÃ³ nghÄ©a thÃ´ng qua Siki, ngÆ°á»i dÃ¹ng sáº½ cÃ³ kháº£ nÄƒng Ä‘Äƒng bÃ¡n sáº£n pháº©m, Ä‘Äƒng tin cáº§n tÃ¬m mua sáº£n pháº©m, tháº­m chÃ­ náº¿u ngÆ°á»i dÃ¹ng Ä‘i chia sáº» link giÃºp cá»™ng Ä‘á»“ng, há» cÅ©ng sáº½ Ä‘Æ°á»£c tá»· lá»‡ % giao dá»‹ch do Siki tÃ i trá»£.\r\nMá»™t lá»£i Ã­ch ná»¯a cá»§a Siki chÃ­nh lÃ  viá»‡c Ä‘a dáº¡ng thanh toÃ¡n khi cÃ¡c giao dá»‹ch trÃªn Siki cÃ³ thá»ƒ thá»±c hiá»‡n Ä‘Æ°á»£c thÃ´ng qua táº¥t cáº£ cÃ¡c ngÃ¢n hÃ ng trong nÆ°á»›c, tháº» náº¡p Ä‘iá»‡n thoáº¡i, hay vÃ­ Ä‘iá»‡n tá»­ Ä‘áº£m báº£o an toÃ n giao dá»‹ch trá»±c tuyáº¿n.\r\nÄÆ°á»£c biáº¿t trong thá»i tá»›i, Siki sáº½ tiáº¿p tá»¥c má»Ÿ rá»™ng máº¡ng lÆ°á»›i liÃªn káº¿t vÃ  cÃ³ nhiá»u chÆ°Æ¡ng trÃ¬nh há»— trá»£ cho ngÆ°á»i sá»­ dá»¥ng. Chi tiáº¿t vui lÃ²ng truy cáº­p http://www.siki.vn Ä‘á»ƒ biáº¿t thÃªm chi tiáº¿t.', '2012-11-10', '0', 1),
(3, 'tin tuc1', '<p>\r\n	Cong hoa xa hoi chug nghia</p>\r\n', '2012-12-02', 'alert-news', 1);

-- --------------------------------------------------------

--
-- Table structure for table `vcn_partners`
--

CREATE TABLE IF NOT EXISTS `vcn_partners` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
