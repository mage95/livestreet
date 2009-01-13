-------------------------------------------------
------------------Changeset [96]-----------------
-------------------------------------------------

--
-- ��������� ������� `prefix_reminder`
--

CREATE TABLE IF NOT EXISTS `prefix_reminder` (
  `reminder_code` varchar(32) NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `reminder_date_add` datetime NOT NULL,
  `reminder_date_used` datetime default '0000-00-00 00:00:00',
  `reminder_date_expire` datetime NOT NULL,
  `reminde_is_used` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`reminder_code`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- ����������� �������� ����� ����������� ������
--

--
-- ����������� �������� ����� ������� `prefix_reminder`
--
ALTER TABLE `prefix_reminder`
  ADD CONSTRAINT `prefix_reminder_fk` FOREIGN KEY (`user_id`) REFERENCES `prefix_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;