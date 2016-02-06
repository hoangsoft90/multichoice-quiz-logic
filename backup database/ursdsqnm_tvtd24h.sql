-- phpMyAdmin SQL Dump
-- version 3.5.8.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 25, 2014 at 03:03 PM
-- Server version: 5.5.33
-- PHP Version: 5.3.27

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ursdsqnm_tvtd24h`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=66 ;

--
-- Dumping data for table `vcn_answers`
--

INSERT INTO `vcn_answers` (`id`, `question`, `answer`, `answer_link_question`, `text2next_question`, `answer_object_type`, `link_object_type`, `partner`) VALUES
(1, 1, 'Người đi làm hưởng lương', '2', '', 0, 0, 0),
(2, 1, 'Chủ doanh nghiệp (có giấy phép kinh doanh)', '', '', 0, 0, 0),
(3, 1, 'Kinh doanh tự do (không có giấy phép kinh doanh)', '', 'Xin lỗi không đủ điều kiện', 0, 0, 0),
(4, 2, 'Dưới 3 tháng', '22', 'Bạn phải làm việc trên 1 năm trở lên mới được vay vốn tại ngân hàng.', 0, 0, 0),
(5, 2, 'Từ 3 đến 6 tháng', '16', '', 0, 0, 0),
(27, 0, '', '', '', 0, 0, 0),
(28, 0, '', '', '', 0, 0, 0),
(35, 2, 'Trên 6 tháng', '16', '', 0, 0, 0),
(36, 16, 'Dưới 3 triệu đồng.', '22', 'Lương yêu cầu tối thiểu 3 triệu.', 0, 0, 0),
(37, 16, 'Từ 3 triệu đến dưới 8 triệu.', '17', '', 0, 0, 0),
(38, 17, 'Chuyển khoản', '18', '', 0, 0, 0),
(39, 17, 'Tiền mặt', '18', '', 0, 0, 0),
(40, 18, 'Có', '24', '', 0, 0, 0),
(41, 18, 'Không', '22', '', 0, 0, 0),
(42, 19, 'Có', 'answer_picker(function(){\r\nif(get_quest_history(16) && get_quest_history(16)[0]==48\r\n  \r\n){\r\n    if(get_quest_history(17) && get_quest_history(17)[0]==38){\r\n         next_question_listener(20,[data.answer_id,data.answer,data.question]);\r\n    }\r\n    else {\r\n      next_question_listener(22,[data.answer_id,data.answer,data.question]);\r\n      set_text2next(22,"Khong du dieu kien");\r\n}\r\n}\r\nelse {\r\n    next_question_listener(22,[data.answer_id,data.answer,data.question]);\r\n    set_text2next(22,"Khong du dieu kien");\r\n}\r\n});', '', 0, 1, 0),
(43, 19, 'Chưa', '23', '', 0, 0, 0),
(44, 20, 'Có', '22', '', 0, 0, 0),
(45, 20, 'Không', '21', '', 0, 0, 0),
(46, 21, 'Dưới 3 triệu đồng', '23', '', 0, 0, 0),
(47, 21, 'Trên 3 triệu đồng', '22', '', 0, 0, 0),
(48, 16, 'Từ 8 triệu trở lên.', '17', '', 0, 0, 0),
(49, 0, '', '', '', 0, 0, 0),
(50, 0, '', '', '', 0, 0, 0),
(51, 23, 'dlg_opt({auto:1,type:''page''});\r\nanswer_callback(function(){set_question_history();set_history_result(1)});', '', '', 1, 0, 0),
(52, 22, 'dlg_opt({auto:1,type:''page''});\r\nanswer_callback(function(){set_question_history();set_history_result(0)});', '', '', 1, 0, 0),
(53, 24, 'Có', '25', '', 0, 0, 0),
(54, 24, 'Không', '19', '', 0, 0, 0),
(55, 25, 'Trên 1 năm', '26', '', 0, 0, 0),
(56, 25, 'Dưới 1 năm', '19', '', 0, 0, 0),
(57, 26, 'Trên 3 triệu', '28', '', 0, 0, 0),
(58, 26, 'Dưới 3 triệu', '19', '', 0, 0, 0),
(59, 27, 'dlg_opt({auto:1,type:''page''});\r\nanswer_callback(function(){set_question_history();set_history_result(1)});', '', '', 1, 0, 0),
(60, 28, 'Có', 'answer_picker(function(){\r\nif(get_quest_history(16) && get_quest_history(16)[0]==48\r\n  \r\n){\r\n    if(get_quest_history(17) && get_quest_history(17)[0]==38){\r\n         next_question_listener(29,[data.answer_id,data.answer,data.question]);\r\n    }\r\n    else {\r\n      next_question_listener(22,[data.answer_id,data.answer,data.question]);\r\n      set_text2next(22,''Khong du dieu kien'');\r\n}\r\n}\r\nelse {\r\n    next_question_listener(22,[data.answer_id,data.answer,data.question]);\r\n    set_text2next(22,''Khong du dieu kien'');\r\n}\r\n});', '', 0, 1, 0),
(61, 28, 'Chưa', '27', '', 0, 0, 0),
(62, 29, 'Có', '22', '', 0, 0, 0),
(63, 29, 'Không', '', '', 0, 0, 0),
(64, 30, 'Trên 3 triệu', '', '', 0, 0, 0),
(65, 30, 'Dưới 3 triệu', '', '', 0, 0, 0);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

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
(1, '', 'Anh/Chị đang đi làm hưởng lương hay là chủ doanh nghiệp?', '', 0, 1, 1),
(2, '', 'Thời gian Anh/Chị làm việc được bao lâu?', '', 0, 0, 1),
(16, '', 'Tổng thu nhập/tháng của Anh(Chị) là:', '', 0, 0, 0),
(17, '', 'Thu nhập trên là nhận qua chuyển khoản hay nhận tiền mặt?', '', 0, 0, 0),
(18, '', 'Anh/Chị có tham gia BHYT do công ty tổ chức không?', '', 0, 0, 0),
(19, '', 'Anh/Chị đã có khoản vay ở tổ chức tín dụng/ngân hàng nào chưa?', '', 0, 0, 1),
(20, '', 'Anh/Chị có bị ngân hàng đánh nợ xấu không?', '', 0, 0, 0),
(21, '', 'Anh/Chị đang phải trả khoản vay đó là bao nhiêu/tháng?', '', 0, 0, 0),
(22, '', 'Xin lỗi. Anh/Chị chưa đủ điều kiện vay!', '', 0, 0, 1),
(23, '', 'Chúc mừng. Anh/chị đã đủ điều kiện vay sản phẩm: VAY THEO LƯƠNG', '', 0, 0, 1),
(24, '', 'Anh/Chị có tham gia BHNT không?', '', 0, 0, 1),
(25, '', 'Thời gian Anh/Chị tham gia BHNT được bao lâu?', '', 0, 0, 0),
(26, '', 'Tiền phí Anh/Chị đóng BHNT hàng năm là bao nhiêu?', '', 0, 0, 1),
(27, '', '*Chúc mừng. Anh/chị đã đủ điều kiện vay sản phẩm: VAY THEO LƯƠNG + VAY THEO BHNT', '', 0, 0, 1),
(28, '', '*Anh/Chị đã có khoản vay ở tổ chức tín dụng/ngân hàng nào chưa?', '', 0, 0, 1),
(29, '', '*Anh/Chị có bị ngân hàng đánh nợ xấu không?', '', 0, 0, 1),
(30, '', '*Anh/Chị đang phải trả khoản vay đó là bao nhiêu/tháng?', '', 0, 0, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `vcn_faq`
--

INSERT INTO `vcn_faq` (`id`, `group_`, `faq`, `answer`) VALUES
(1, 1, 'dsfgdfg', 'sdgdfgdfg');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `vcn_histories1`
--

CREATE TABLE IF NOT EXISTS `vcn_histories1` (
  `hid` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `answer_text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
