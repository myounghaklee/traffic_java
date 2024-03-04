-- board.category definition

CREATE TABLE `category` (
                            `id` int NOT NULL AUTO_INCREMENT,
                            `name` varchar(100) DEFAULT NULL,
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- board.comment definition

CREATE TABLE `comment` (
                           `id` int NOT NULL AUTO_INCREMENT,
                           `postId` int DEFAULT NULL,
                           `contents` varchar(300) DEFAULT NULL,
                           `subCommentsId` int DEFAULT NULL,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- board.file definition

CREATE TABLE `file` (
                        `id` int NOT NULL AUTO_INCREMENT,
                        `path` varchar(100) DEFAULT NULL,
                        `extension` varchar(100) DEFAULT NULL,
                        `postId` int DEFAULT NULL,
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- board.post definition

CREATE TABLE `post` (
                        `id` int NOT NULL AUTO_INCREMENT,
                        `isAdmin` tinyint DEFAULT NULL,
                        `contents` varchar(500) DEFAULT NULL,
                        `createTime` datetime DEFAULT NULL,
                        `views` int DEFAULT NULL,
                        `categoryId` int DEFAULT NULL,
                        `userId` int DEFAULT NULL,
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- board.postTag definition

CREATE TABLE `postTag` (
                           `id` int NOT NULL AUTO_INCREMENT,
                           `postId` int DEFAULT NULL,
                           `tagId` int DEFAULT NULL,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- board.tag definition

CREATE TABLE `tag` (
                       `id` int NOT NULL AUTO_INCREMENT,
                       `name` varchar(100) DEFAULT NULL,
                       `url` varchar(100) DEFAULT NULL,
                       PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- board.`user` definition

CREATE TABLE `user` (
                        `id` int NOT NULL AUTO_INCREMENT,
                        `password` varchar(100) DEFAULT NULL,
                        `nickname` varchar(100) DEFAULT NULL,
                        `isAdmin` tinyint DEFAULT NULL,
                        `createTime` datetime DEFAULT NULL,
                        `isWithDraw` tinyint DEFAULT NULL,
                        `userId` varchar(100) DEFAULT NULL,
                        `status` varchar(100) DEFAULT NULL,
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;