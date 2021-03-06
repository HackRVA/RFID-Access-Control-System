use rfid_auth;
-- --------------------------------------------------------------------------------
-- user_upsert stored routine
-- inserts a row if p_id is 0, otherwise updates the row with the id specified
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_upsert`(
	IN	p_id				INT,
	IN	p_locked_out		BOOL,
	IN	p_name			VARCHAR(45)
)
BEGIN
	DECLARE row_id INT;
	IF p_id = 0 THEN
		INSERT INTO `rfid_auth`.`user`
		(
			`id`,
			`locked_out`,
			`name`,
			`create_datetime`
		)
		VALUES
		(
			p_id,
			p_locked_out,
			p_name,
			now()
		);
		SET row_id = last_insert_id();
	ELSE
		UPDATE `rfid_auth`.`user`
		SET
			locked_out = p_locked_out,
			name = p_name
		WHERE
			id = p_id;
		SET row_id = p_id;
	END IF;
	
	SELECT * FROM user 
	WHERE id = row_id;
END