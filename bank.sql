/*
Navicat MySQL Data Transfer

Source Server         : ayyll
Source Server Version : 50550
Source Host           : localhost:3306
Source Database       : bank

Target Server Type    : MYSQL
Target Server Version : 50550
File Encoding         : 65001

Date: 2017-05-04 11:39:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `card` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sex` varchar(10) NOT NULL DEFAULT '性别不详',
  `money` int(11) DEFAULT '10',
  `open_date` datetime DEFAULT NULL,
  `password` varchar(50) NOT NULL DEFAULT '123456',
  `isDelete` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`,`card`),
  UNIQUE KEY `card_2` (`card`),
  KEY `card` (`card`)
) ENGINE=InnoDB AUTO_INCREMENT=1182 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('1176', '3151913930', '刘德华', '男', '100', '2017-04-15 21:32:50', '123067', '1');
INSERT INTO `account` VALUES ('1177', '3403720802', '张翼德', '男', '111', '2017-04-15 21:33:34', '1234567', '0');
INSERT INTO `account` VALUES ('1178', '8904651075', '貂蝉', '女', '323', '2017-04-15 21:33:49', '123456', '0');
INSERT INTO `account` VALUES ('1179', '2309968109', '刘德华', '男', '102', '2017-04-15 21:40:23', '968109', '1');
INSERT INTO `account` VALUES ('1180', '1885507354', '奥利安娜', '女', '1111', '2017-04-17 11:29:19', '123456', '0');
INSERT INTO `account` VALUES ('1181', '7638827485', '刘德华', '男', '102', '2017-04-17 11:33:13', '827485', '0');

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card` varchar(50) NOT NULL,
  `deal` int(11) NOT NULL DEFAULT '0',
  `msg` varchar(50) DEFAULT NULL,
  `deal_time` datetime NOT NULL,
  PRIMARY KEY (`id`,`card`),
  KEY `card_fk` (`card`),
  CONSTRAINT `card_fk` FOREIGN KEY (`card`) REFERENCES `account` (`card`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES ('1', '2309968109', '11', '存款', '2017-04-15 21:41:14');
INSERT INTO `log` VALUES ('2', '2309968109', '11', '取款', '2017-04-15 21:42:26');
INSERT INTO `log` VALUES ('3', '2309968109', '-1', '取款', '2017-04-15 21:42:50');
INSERT INTO `log` VALUES ('4', '1885507354', '1', '存款', '2017-04-15 21:45:46');

-- ----------------------------
-- Table structure for pagination
-- ----------------------------
DROP TABLE IF EXISTS `pagination`;
CREATE TABLE `pagination` (
  `page` int(11) NOT NULL,
  `count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pagination
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '123456');
