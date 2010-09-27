use rfid_auth;
-- --------------------------------------------------------------------------------
-- tag_upsert stored routine
-- inserts a row if p_id is 0, otherwise updates the row with the id specified
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tag_upsert`(
	IN	p_id				INT,
	IN	p_user_id			INT,
	IN	p_tag_data			VARCHAR(20)
)
BEGIN
	DECLARE row_id INT;
	IF p_id = 0 THEN
		INSERT INTO `rfid_auth`.`tag`
		(
			`id`,
			`user_id`,
			`tag_data`
		)
		VALUES
		(
			p_id,
			p_user_id,
			p_tag_data
		);
		SET row_id = last_insert_id();
	ELSE
		UPDATE `rfid_auth`.`tag`
		SET
			user_id = p_user_id,
			tag_data = p_tag_data
		WHERE
			id = p_id;
	END IF;

	SELECT * FROM tag 
	WHERE id = row_id;
END