-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 01, 2014 at 04:59 AM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `test2`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_contents`( db_name varchar(100))
begin
declare finish int default 0;
declare tab varchar(100);
declare cur_tables cursor for select table_name from information_schema.tables where table_schema = db_name and table_type = 'base table';
declare continue handler for not found set finish = 1;
open cur_tables;
my_loop:loop
fetch cur_tables into tab;
if finish = 1 then
leave my_loop;
end if;

set @str = concat('truncate ', tab);
prepare stmt from @str;
execute stmt;
deallocate prepare stmt;
end loop;
close cur_tables;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ham1`()
begin
	declare b int default 0;
	declare done int default false;
	declare tab varchar(100);
	declare cur_tables cursor for select table_name from information_schema.tables where table_schema = "test" and table_type = 'base table';
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	open cur_tables;
	
	my_loop:loop
		fetch cur_tables into tab;
		if done=true then
			leave my_loop;
		end if;
                if tab!="tab1" or tab!="tab2" then
			set @str = concat("drop table ",tab,";");		
                	prepare stmt from @str;		
                	execute stmt;
                	deallocate prepare stmt;
                end if;
	end loop my_loop;
	close cur_tables;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `replace_all`(in db varchar(50),find varchar(100),repl varchar(100))
    MODIFIES SQL DATA
begin
declare done int default 0;
declare tab varchar(100);
declare cur cursor for select table_name from information_schema.tables where table_schema = db and table_type = 'base table';
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
open cur;
my_loop:loop
	fetch cur into tab;
	if done=1 then
		leave my_loop;
	end if;
	call replace_table(db,tab,find,repl);
end loop my_loop;
close cur;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `replace_table`(in db varchar(100),in tab varchar(50),find varchar(100),repl varchar(100))
begin
declare done int default 0;
declare col varchar(100);
declare out_status text;
declare cur cursor for select distinct column_name from information_schema.columns where TABLE_SCHEMA = 'test' and table_name = tab order by ordinal_position;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
DECLARE CONTINUE HANDLER FOR 1175 SET out_status='Duplicate Entry';
DECLARE CONTINUE HANDLER FOR 1242 SET out_status='error 1242';
open cur;
set @field_key:=(SELECT COLUMN_NAME FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=db and TABLE_NAME = tab AND COLUMN_KEY = 'PRI');

my_loop:loop
	fetch cur into col;
	if done=1 then
		leave my_loop;
	end if;
	if @field_key=col then
		ITERATE my_loop;
	end if;
	
	set @str=concat("update ",tab," set ",col,"=replace(",col,',"',find,'",','"',repl,'");');
	select @str;
	prepare stmt from @str;
	execute stmt;
	deallocate prepare stmt;

end loop my_loop;
close cur;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `test_multi_sets`()
    DETERMINISTIC
begin
        select user() as first_col;
        select user() as first_col, now() as second_col;
        select user() as first_col, now() as second_col, now() as third_col;
        end$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `a`(n INT, m INT) RETURNS varchar(20) CHARSET latin1
BEGIN
    DECLARE s VARCHAR(20);

    IF n > m THEN SET s = '>';
    ELSEIF n = m THEN SET s = '=';
    ELSE SET s = '<';
    END IF;

    SET s = CONCAT(n, ' ', s, ' ', m);

    RETURN s;
  END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `ham1`(a int) RETURNS varchar(20) CHARSET latin1
begin
		DECLARE s VARCHAR(20);
		return "sdf";
	end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `ham2`(a int) RETURNS varchar(20) CHARSET latin1
begin
		return "huy";
	end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `SimpleCompare`(n INT, m INT) RETURNS varchar(20) CHARSET latin1
BEGIN
    DECLARE s VARCHAR(20);

    IF n > m THEN SET s = '>';
    ELSEIF n = m THEN SET s = '=';
    ELSE SET s = '<';
    END IF;

    SET s = CONCAT(n, ' ', s, ' ', m);

    RETURN s;
  END$$

DELIMITER ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=36 ;

--
-- Dumping data for table `vcn_answers`
--

INSERT INTO `vcn_answers` (`id`, `question`, `answer`, `answer_link_question`, `text2next_question`, `answer_object_type`, `link_object_type`, `partner`) VALUES
(1, 1, 'The wage employment', '2', '', 0, 0, 0),
(2, 1, 'Business owners (business license)', '11', '', 0, 0, 0),
(3, 1, 'Business freedom (no business license)', '13', 'Sorry, you are not eligible', 0, 0, 0),
(4, 2, 'Less than 1 year', '13', 'You have to work on the 1 year or older to bank loans.', 0, 0, 0),
(5, 2, 'Over 1 year', '3', '', 0, 0, 0),
(6, 3, 'Yes', '4', '', 0, 0, 0),
(7, 3, 'No', '6', '', 0, 0, 0),
(8, 4, 'Over 1 year', '5', '', 0, 0, 0),
(9, 4, 'Under 1 year', '6', '', 0, 0, 0),
(10, 5, 'From 1 million or over', '', '', 0, 0, 0),
(11, 5, 'Less than 1 million', '', '', 0, 0, 0),
(12, 6, 'No', '13', 'You are not eligible', 0, 0, 0),
(13, 6, 'Yes', '10', '', 0, 0, 0),
(14, 7, 'Ya', '', '', 0, 0, 0),
(15, 7, 'Yet', '', '', 0, 0, 0),
(16, 8, 'Yes', '13', 'Oops! all customers would be guest Bank bad debt loan not being anywhere.', 0, 0, 0),
(17, 8, 'No', '9', '', 0, 0, 0),
(18, 9, 'Under 4 million', '13', 'Your salary must be more than 4 million', 0, 0, 0),
(19, 9, 'From 4 million and over', '10', '', 0, 0, 0),
(20, 9, 'From 4.5 million and over', '10', '', 0, 0, 0),
(21, 10, 'Da Nang', '11', '', 0, 0, 0),
(22, 10, 'Quang Nam', '11', '', 0, 0, 0),
(23, 11, 'Under 2 years', '13', 'Must be 2 years or more', 0, 0, 0),
(24, 11, 'From 2 years and up', '12', '', 0, 0, 0),
(25, 12, 'Yes', '14', '', 0, 0, 0),
(26, 12, 'No', '13', '', 0, 0, 0),
(27, 0, '', '', '', 0, 0, 0),
(28, 0, '', '', '', 0, 0, 0),
(31, 13, 'dlg_opt({auto:1,type:''page''});\r\nanswer_callback(function(){set_question_history();set_history_result(0);});', '', '', 1, 0, 0),
(32, 14, 'dlg_opt({auto:1,type:''page''});\r\nanswer_callback(function(){set_question_history();set_history_result(1);});', '', '', 1, 0, 0),
(33, 10, 'Other', '13', 'Sorry this page we only support in Quang nam and Da Nang', 0, 0, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=16 ;

--
-- Dumping data for table `vcn_data`
--

INSERT INTO `vcn_data` (`id`, `group_title`, `question`, `action`, `link_question`, `has_faq`, `default_question_css`) VALUES
(1, '', 'Who are you in this?', '', 0, 1, 1),
(2, '', 'Time how long you work?', '', 0, 0, 1),
(3, '', 'Are you participating life insurance?', '', 0, 0, 1),
(4, '', 'You buy life insurance for how long?', '', 0, 0, 1),
(5, '', 'Total life insurance premiums in a year?', '', 6, 0, 1),
(6, '', 'The company has made HEALTH INSURANCE for you?', '', 0, 0, 1),
(7, '', 'You have a loan in another bank?', '', 8, 0, 1),
(8, '', 'Do you suffer from bad debt in banks?', '', 0, 0, 1),
(9, '', 'how much is your salary?', '', 0, 0, 1),
(10, '', 'Where is your company?', '', 0, 0, 1),
(11, '', 'Business license registration tax code for how long.', '', 0, 0, 1),
(12, '', 'You have a credit card?', '', 0, 0, 1),
(13, '', 'We consider that the conditions are not sufficient to obtain loans', '', 0, 0, 0),
(14, '', 'Congratulations you have eligible loans, please prepare the following documents..', '', 0, 0, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `vcn_faq`
--

INSERT INTO `vcn_faq` (`id`, `group_`, `faq`, `answer`) VALUES
(2, 1, 'sfdsf', 'sdfdsf');

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
