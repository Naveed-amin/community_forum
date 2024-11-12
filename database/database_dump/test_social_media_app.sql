-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 12, 2024 at 04:59 PM
-- Server version: 8.2.0
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test_social_media_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `post_id` bigint UNSIGNED DEFAULT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `post_id`, `parent_id`, `content`, `created_at`, `updated_at`) VALUES
(1, 2, 13, NULL, 'Hello Comment one', '2024-11-12 10:54:06', '2024-11-12 10:54:06'),
(2, 1, 15, NULL, 'The Fantastic Post', '2024-11-12 10:56:05', '2024-11-12 10:56:05'),
(3, 1, 13, NULL, 'Great Post', '2024-11-12 10:56:51', '2024-11-12 10:56:51'),
(4, 1, 11, NULL, 'cooment', '2024-11-12 11:01:17', '2024-11-12 11:01:17'),
(5, 1, 15, NULL, 'helllllllllllllllllllllllo', '2024-11-12 11:09:14', '2024-11-12 11:09:14'),
(6, 1, 13, NULL, 'this is my 3rd Comment', '2024-11-12 11:38:37', '2024-11-12 11:38:37'),
(7, 1, 12, NULL, '1st Comment on this post', '2024-11-12 11:43:11', '2024-11-12 11:43:11'),
(8, 1, 12, NULL, '2nd comment on this post', '2024-11-12 11:44:41', '2024-11-12 11:44:41'),
(9, 2, 12, 8, 'comment reply 2nd comment on this post', '2024-11-12 11:44:41', '2024-11-12 11:44:41');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
CREATE TABLE IF NOT EXISTS `likes` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `like_type` enum('Like','Dislike') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Like',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`id`, `post_id`, `user_id`, `like_type`, `created_at`, `updated_at`) VALUES
(4, 13, 1, 'Like', '2024-11-03 08:21:10', '2024-11-03 08:21:10'),
(9, 14, 1, 'Like', '2024-11-03 08:26:18', '2024-11-03 08:26:18');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_11_02_135948_create_posts_table', 1),
(5, '2024_11_02_150657_create_likes_table', 2),
(6, '2024_11_03_134135_create_shares_table', 3),
(7, '2024_11_05_170804_add_parent_id_to_posts_table', 4),
(8, '2024_11_06_155820_create_comments_table', 5);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `title` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shared_content` text COLLATE utf8mb4_unicode_ci,
  `shared_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `parent_id`, `user_id`, `name`, `description`, `title`, `image`, `shared_content`, `shared_image`, `created_at`, `updated_at`) VALUES
(1, NULL, 12, 'Vitae rerum molestiae unde odio dignissimos accusamus sit.', 'Excepturi cum minima aut. Quod pariatur repellat cum id. Accusantium unde esse dignissimos totam temporibus.', 'Suscipit distinctio a harum qui.', 'https://via.placeholder.com/640x480.png/003366?text=posts+totam', NULL, NULL, '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(2, NULL, 13, 'Delectus corrupti ratione in aspernatur aut porro.', 'Qui corrupti autem sed sit sed rem. Aliquam voluptatum nihil incidunt. Dolores quo tempora voluptatibus deserunt. Aut eum placeat dignissimos omnis.', 'Ut pariatur qui eos alias ut dolor eaque voluptas.', 'https://via.placeholder.com/640x480.png/00ffff?text=posts+eum', NULL, NULL, '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(3, NULL, 14, 'Reiciendis tenetur aliquam quidem sit mollitia sequi animi.', 'Et sit eos et est qui. Maiores id perferendis possimus sunt. Modi voluptate perferendis error et ut non ea repellendus. Minima in sequi rerum deserunt autem.', 'Repudiandae dolor veritatis molestiae voluptatem qui et.', 'https://via.placeholder.com/640x480.png/00ffff?text=posts+aut', NULL, NULL, '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(4, NULL, 15, 'Dignissimos aliquam ad rerum tempora.', 'Voluptas asperiores fuga in quidem eveniet sed libero. Cupiditate harum asperiores ut voluptatem quia. Nihil aut id voluptas excepturi corporis non. Enim libero est culpa ut ab deserunt illum.', 'Magni nesciunt iste architecto neque inventore non.', 'https://via.placeholder.com/640x480.png/0033cc?text=posts+aspernatur', NULL, NULL, '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(5, NULL, 16, 'Sunt reprehenderit eaque numquam rerum.', 'Qui qui illo eius ratione expedita iste doloribus. Ea consequatur velit nihil magnam. Mollitia voluptates quo quia qui. Qui qui temporibus quis aliquam blanditiis. Illum aut autem sit fugiat porro.', 'Sit dignissimos ab ipsa rem illo.', 'https://via.placeholder.com/640x480.png/0088dd?text=posts+tempora', NULL, NULL, '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(6, NULL, 17, 'Et assumenda eum laboriosam ut.', 'Unde et qui sint qui aspernatur corporis architecto. Corporis molestias non quod illum. Quod et sit ut porro laudantium est quidem.', 'Assumenda quos officia saepe reprehenderit nesciunt omnis.', 'https://via.placeholder.com/640x480.png/00ee99?text=posts+quis', NULL, NULL, '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(7, NULL, 18, 'Itaque neque dolorum aut est.', 'Omnis soluta eum doloribus laudantium consectetur. Nulla ipsam atque quia voluptate. Accusantium rerum eum provident aliquid.', 'Et sit voluptatibus iste vero aliquid.', 'https://via.placeholder.com/640x480.png/00ffcc?text=posts+esse', NULL, NULL, '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(8, NULL, 19, 'Libero voluptas delectus dolor alias minus recusandae quaerat ex.', 'Vitae ipsa nihil et sint vel omnis id. Saepe et dolorum pariatur odit possimus quia. Eligendi nulla qui quia.', 'Quia iure nesciunt vitae a eaque dolorem nobis officia.', 'https://via.placeholder.com/640x480.png/0099ee?text=posts+molestiae', NULL, NULL, '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(9, NULL, 20, 'Iure quisquam sunt non corporis.', 'Et cupiditate sed ratione ex sunt deleniti temporibus ipsa. Ducimus sed magnam molestiae repellendus laudantium. Id mollitia animi et odio aliquam nemo iure.', 'Occaecati dolore qui odio veritatis expedita eum eligendi.', 'https://via.placeholder.com/640x480.png/00ffaa?text=posts+voluptate', NULL, NULL, '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(10, NULL, 21, 'Velit et delectus quos ipsum voluptatem.', 'Distinctio odio maiores excepturi est voluptatum nobis suscipit. Et ut quo architecto saepe. Omnis consectetur enim est nihil facilis nihil minima. Repellendus qui quo veritatis odio.', 'Occaecati omnis aut iure facere et sunt molestiae.', 'https://via.placeholder.com/640x480.png/0088cc?text=posts+dolorem', NULL, NULL, '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(11, NULL, 1, 'This is My 1st  post', NULL, NULL, 'images/DZKikrxBJ9lMDOe8h3h6OjQhX1UaDbU5nH0snfyV.png', NULL, NULL, '2024-11-03 07:44:54', '2024-11-03 07:44:54'),
(12, NULL, 1, 'Hello From Post', NULL, NULL, 'images/L8W67X4xdqq2w7CuNAQ7bPqroGlTxh2ODtE5sUzS.png', NULL, NULL, '2024-11-03 08:15:18', '2024-11-03 08:15:18'),
(13, NULL, 1, 'dasdasd', NULL, NULL, 'images/CvsoZejd3ZYdwwZx23qbDuRzkCDsNuh2IpOVZSyc.png', NULL, NULL, '2024-11-03 08:17:46', '2024-11-03 08:17:46'),
(15, 13, 1, 'dasdasd', NULL, NULL, 'images/CvsoZejd3ZYdwwZx23qbDuRzkCDsNuh2IpOVZSyc.png', 'Hello', NULL, '2024-11-05 12:17:12', '2024-11-05 12:17:12');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('B7m2R6DkanUngkKZ60qHHP92iEaf4tcujsJt0Y8U', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoid2REOTI1S1M2NFZCR3kxVjNvSVdiaVlvOWlUYkZDaEhkOVFBTWwwUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9wb3N0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1731430715);

-- --------------------------------------------------------

--
-- Table structure for table `shares`
--

DROP TABLE IF EXISTS `shares`;
CREATE TABLE IF NOT EXISTS `shares` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `comment` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Naveed Amin', 'naveedmughal1182@gmail.com', '2024-11-02 09:27:00', '$2y$12$U.gJ3UY/7Tt5Hx3TB8eF2exjh3KuGkQg47vEVzIulnFv0ITTtNNw2', 'Qqm0z0bcCNeUgkytL2BHoKuZezFI5Fpzz7SOSiFoXZJ8vucLWQEaEbTpkUif', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(2, 'Florida Leannon', 'jaskolski.irving@example.com', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'lQZFLO7Fj3', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(3, 'Prof. Damian Miller DVM', 'walter.archibald@example.com', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'xQdiAUULAZ', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(4, 'Mrs. Janiya Schmidt', 'lonnie00@example.net', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'Wg53jzupUN', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(5, 'Jeremy Kuhlman', 'cormier.reece@example.net', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'msOIFeyQmi', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(6, 'Cullen Skiles Sr.', 'wilkinson.clovis@example.net', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', '9Jj2wtu0Wh', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(7, 'Gerard O\'Reilly', 'sarina.green@example.org', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'w53zCkkvmf', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(8, 'Zion Schneider', 'lynch.tremayne@example.org', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'LnTxXUw7yE', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(9, 'Valentin Green Jr.', 'kale38@example.org', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'SzFEXc7EWd', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(10, 'Prof. Eryn Oberbrunner', 'zachariah89@example.com', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'zhKMy4lMWU', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(11, 'Gabrielle Blanda IV', 'timmy.jacobson@example.com', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', '2e4RVrQq68', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(12, 'Prof. Federico Berge DDS', 'tiana60@example.org', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', '5qS9glhqhP', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(13, 'Ezequiel Crooks', 'sigurd22@example.net', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'pq13OhMjSv', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(14, 'Beau Kshlerin', 'rstamm@example.com', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'McXddmCdfj', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(15, 'Andy Roob I', 'zella23@example.org', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'EHI30cbnUx', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(16, 'Dr. Fernando Hamill I', 'doyle.fiona@example.com', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'FVU7C1kfNh', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(17, 'Aryanna Jerde', 'krista15@example.net', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'h8pdU58Pgm', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(18, 'Helene Mills', 'jakubowski.phyllis@example.com', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'h564RsyHXt', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(19, 'Jaycee Koss', 'ratke.jamey@example.org', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'Copv1eA2kQ', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(20, 'Marques Bashirian Jr.', 'ferry.shayna@example.net', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', '3ilST6yTet', '2024-11-02 09:27:00', '2024-11-02 09:27:00'),
(21, 'Ignacio Ankunding Sr.', 'alfonzo04@example.org', '2024-11-02 09:27:00', '$2y$12$/87PEKrjUPjVO4/Ub.6Ude2TcmmPdyi0XrCNsc.xzm0RwVIyPFQKa', 'LvqH3TqHVy', '2024-11-02 09:27:00', '2024-11-02 09:27:00');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
