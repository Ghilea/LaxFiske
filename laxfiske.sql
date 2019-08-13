-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Värd: 127.0.0.1:3306
-- Tid vid skapande: 07 jun 2019 kl 05:49
-- Serverversion: 5.7.24
-- PHP-version: 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databas: `laxfiske`
--

-- --------------------------------------------------------

--
-- Tabellstruktur `account`
--

DROP TABLE IF EXISTS `account`;
CREATE TABLE IF NOT EXISTS `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` varchar(255) COLLATE latin1_bin NOT NULL,
  `latitude` float(10,8) NOT NULL,
  `longitude` float(11,8) NOT NULL,
  `time` time NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumpning av Data i tabell `account`
--

INSERT INTO `account` (`id`, `device_id`, `latitude`, `longitude`, `time`) VALUES
(1, '6b356755575fce31', 60.55847931, 17.43647194, '19:55:27'),
(2, '7d1b3cbacb01b4d6', 60.67387772, 17.17031670, '20:17:20'),
(3, 'e48824e2e915da15', 60.67388153, 17.17034149, '12:42:58');

-- --------------------------------------------------------

--
-- Tabellstruktur `account_coupons`
--

DROP TABLE IF EXISTS `account_coupons`;
CREATE TABLE IF NOT EXISTS `account_coupons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `partner_coupons_id` int(11) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- --------------------------------------------------------

--
-- Tabellstruktur `account_quest`
--

DROP TABLE IF EXISTS `account_quest`;
CREATE TABLE IF NOT EXISTS `account_quest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `game_quest_id` int(11) NOT NULL,
  `game_quest_information_id` int(11) NOT NULL,
  `game_status_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

--
-- Dumpning av Data i tabell `account_quest`
--

INSERT INTO `account_quest` (`id`, `account_id`, `game_quest_id`, `game_quest_information_id`, `game_status_id`) VALUES
(1, 1, 1, 1, 1),
(2, 1, 1, 2, 2),
(3, 1, 1, 3, 2),
(4, 1, 1, 4, 2),
(5, 1, 1, 5, 2),
(6, 1, 1, 6, 2),
(7, 1, 1, 7, 2),
(8, 1, 1, 8, 2),
(9, 1, 2, 9, 1),
(10, 2, 1, 1, 1),
(11, 2, 1, 2, 2),
(12, 2, 1, 3, 2),
(13, 2, 1, 4, 2),
(14, 2, 1, 5, 2),
(15, 2, 1, 6, 2),
(16, 2, 1, 7, 2),
(17, 2, 1, 8, 2),
(18, 2, 2, 9, 1),
(19, 3, 1, 1, 1),
(20, 3, 1, 2, 2),
(21, 3, 1, 3, 2),
(22, 3, 1, 4, 2),
(23, 3, 1, 5, 2),
(24, 3, 1, 6, 2),
(25, 3, 1, 7, 2),
(26, 3, 1, 8, 2),
(27, 3, 2, 9, 1);

-- --------------------------------------------------------

--
-- Tabellstruktur `account_zone`
--

DROP TABLE IF EXISTS `account_zone`;
CREATE TABLE IF NOT EXISTS `account_zone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `game_zone_id` int(11) NOT NULL,
  `game_status_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumpning av Data i tabell `account_zone`
--

INSERT INTO `account_zone` (`id`, `account_id`, `game_zone_id`, `game_status_id`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 1, 3, 1),
(4, 1, 4, 1),
(5, 2, 1, 1),
(6, 2, 2, 1),
(7, 2, 3, 1),
(8, 2, 4, 1),
(9, 3, 1, 1),
(10, 3, 2, 1),
(11, 3, 3, 1),
(12, 3, 4, 1);

-- --------------------------------------------------------

--
-- Tabellstruktur `game_fish_zone`
--

DROP TABLE IF EXISTS `game_fish_zone`;
CREATE TABLE IF NOT EXISTS `game_fish_zone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumpning av Data i tabell `game_fish_zone`
--

INSERT INTO `game_fish_zone` (`id`, `title`, `description`, `latitude`, `longitude`) VALUES
(1, '1', '', '60.56437683', '17.43674850'),
(2, '2', '', '60.56402206', '17.43767548'),
(3, '3', '', '60.56354904', '17.43789673'),
(4, '4', '', '60.56281855', '17.43797797'),
(5, '5', '', '60.56213048', '17.43760647'),
(6, '6', '', '60.56117060', '17.43644843'),
(7, '7', '', '60.55894168', '17.43607343'),
(8, '8', '', '60.55829376', '17.43624782');

-- --------------------------------------------------------

--
-- Tabellstruktur `game_poll`
--

DROP TABLE IF EXISTS `game_poll`;
CREATE TABLE IF NOT EXISTS `game_poll` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE latin1_bin NOT NULL,
  `q1` varchar(255) COLLATE latin1_bin NOT NULL,
  `q2` varchar(255) COLLATE latin1_bin NOT NULL,
  `q3` varchar(255) COLLATE latin1_bin NOT NULL,
  `answer` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumpning av Data i tabell `game_poll`
--

INSERT INTO `game_poll` (`id`, `title`, `q1`, `q2`, `q3`, `answer`) VALUES
(1, 'Hur många butiker finns det i Gallerian 9an?', '36', '43', '52', 'q2'),
(3, 'Vilken butik kan du hitta innanför Berggrenska gården?', 'Grillo', 'Ascot', 'Gimlins', 'q1'),
(2, 'Var hittar du Naturkompaniet?', 'Rådhustorget', 'Nygatan ', 'Drottninggatan', 'q3'),
(4, 'Vilken musikbutik ligger på Nygatan?', 'Hi-fi klubben', '4 sound', 'Ingen av dem', 'q2');

-- --------------------------------------------------------

--
-- Tabellstruktur `game_quest`
--

DROP TABLE IF EXISTS `game_quest`;
CREATE TABLE IF NOT EXISTS `game_quest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `quest` int(11) NOT NULL,
  `code` varchar(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumpning av Data i tabell `game_quest`
--

INSERT INTO `game_quest` (`id`, `title`, `quest`, `code`) VALUES
(1, 'Tryck här för att komma igång', 8, '654321'),
(2, 'Gör ditt första kast', 1, '123456');

-- --------------------------------------------------------

--
-- Tabellstruktur `game_quest_information`
--

DROP TABLE IF EXISTS `game_quest_information`;
CREATE TABLE IF NOT EXISTS `game_quest_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_quest_id` int(11) NOT NULL,
  `experience` bigint(20) NOT NULL,
  `gold` int(11) NOT NULL,
  `text` text CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumpning av Data i tabell `game_quest_information`
--

INSERT INTO `game_quest_information` (`id`, `game_quest_id`, `experience`, `gold`, `text`, `latitude`, `longitude`) VALUES
(1, 1, 100, 5, 'Menyknappar \r\n\r\n<img class=\"tutorialImg\" src=\"images/svg/book.svg\" alt=\"\"> Via \"Handboken\" samlas all information som du läst. Du kan också se vilken utrustning eller hur stor chans du har att få upp olika sorters fiskar. Information om företag som har ett samarbete eller sponsrar appen finns också här.\r\n\r\n<img class=\"tutorialImg\" src=\"images/svg/star.svg\" alt=\"\"> \"Rabatter\" samlar dina rabattkuponger och vinstkoder som du kan hitta genom att göra uppdrag, fiska eller gå till olika områden.\r\n\r\n<img class=\"tutorialImg\" src=\"images/svg/bag.svg\" alt=\"\"> I \"Butiken\" hittar du utrustning att använda i spelet. Du kan också se produkter från företag som samarbetar eller sponsrar denna app.\r\n\r\n<img class=\"tutorialImg\" src=\"images/svg/map.svg\" alt=\"\"> För att kunna se var olika områdesplatser finns kan du trycka på \"Karta\". Här visas även dina uppdrag.', '60.67419800', '17.15083800'),
(2, 1, 100, 5, '<img class=\"tutorialImg\" src=\"images/svg/fishing_rod.svg\" alt=\"\"> När du står vid ett område nära vatten blir fiskeknappen mer synlig och kan användas för att fiska med. ', '60.67230800', '17.14656700'),
(3, 1, 100, 5, 'När du tryckt på fiskeknappen dra du mobilen bakåt för att hamna i startposition. Vänta sedan 3 sekunder innan du kan dra mobilen åt andra sidan. \r\n\r\nEn snabbare rörelsekast ger bättre kastlängd på linan. Du kan också öka dina förutsättningar genom att hitta eller köpa utrustning i appen. ', '60.67383400', '17.14997600'),
(4, 1, 100, 5, 'När du fått ett bra kast vevar du sedan in linan med hjälp av att göra ett vevliknande rörelse med mobilen. \r\n\r\nFör dig som kan ha besvär med armen går det bra att dra mobilens sida fram och tillbaka för att få samma förutsättningar. \r\n\r\nFiskar kan nappa medan du dra in linan. För att inte linan ska gå av när en fisk sitter på kroken kan det vara bra att sänka hastigheten på vevandet.  ', '60.67860100', '17.11979000'),
(5, 1, 100, 5, 'Du kan dra upp olika sorters fiskar, men också skräp som finns i vattnet. Ibland om turen är med dig kan du hitta fina vinster från företag som samarbetar eller är sponsorer. \r\n\r\nVikten och antalet fiskar du får upp räknas ihop varje månad för ännu fler fina vinster för de som hamnar på topt5 listan. ', '60.67141100', '17.14808600'),
(6, 1, 100, 5, 'Du kommer automatiskt få nya uppdrag varje dag som du kan göra. Vissa uppdrag får du veckovis. \r\n\r\nVarje uppdrag kan ge dig vinster/utrustning till appen eller intressant fakta om området.', '60.67141100', '17.14808600'),
(7, 1, 100, 5, '?', '60.67328500', '17.14676000'),
(8, 1, 500, 20, '?', '60.67201700', '17.16066900'),
(9, 2, 1500, 50, 'Ta dig till vattnet nära Laxön och gör ditt första kast. Kanske har du turen på din sida med att hitta den legendariska gammellaxen.', '60.55813183', '17.43635767');

-- --------------------------------------------------------

--
-- Tabellstruktur `game_status`
--

DROP TABLE IF EXISTS `game_status`;
CREATE TABLE IF NOT EXISTS `game_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(15) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumpning av Data i tabell `game_status`
--

INSERT INTO `game_status` (`id`, `title`) VALUES
(1, 'Active'),
(2, 'Inactive'),
(3, 'Locked');

-- --------------------------------------------------------

--
-- Tabellstruktur `game_zone`
--

DROP TABLE IF EXISTS `game_zone`;
CREATE TABLE IF NOT EXISTS `game_zone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumpning av Data i tabell `game_zone`
--

INSERT INTO `game_zone` (`id`, `title`, `description`, `latitude`, `longitude`) VALUES
(1, 'VattenFall', '', '60.56351697', '17.44130907'),
(2, 'SLU', '', '60.55939801', '17.43473095'),
(3, 'Restaurang Kungsådran', '', '60.56146777', '17.43618471'),
(4, 'Café Furiren', '', '60.56236155', '17.43618471');

-- --------------------------------------------------------

--
-- Tabellstruktur `partner`
--

DROP TABLE IF EXISTS `partner`;
CREATE TABLE IF NOT EXISTS `partner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE latin1_bin NOT NULL,
  `description` text COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumpning av Data i tabell `partner`
--

INSERT INTO `partner` (`id`, `title`, `description`) VALUES
(1, 'Åhléns', 'Familjeföretaget Åhléns grundades 1899 i Insjön och är idag ett av Sveriges starkaste varumärken, med 61 varuhus i Sverige och e-handel via åhlens.se. Vi är varuhuset som erbjuder en smart mix av prisvärda produkter på ett inspirerande, enkelt och lättillgängligt sätt. Åhléns omsätter 4,8 miljarder och varje år tar våra 3 000 skickliga medarbetare emot ca 80 miljoner besök. Åhléns är en del av detaljhandelskoncernen Axel Johnson AB.\r\n\r\nKom in och hitta dina favoriter inom kläder, accessoarer, skönhet, doft och inredning!'),
(2, 'Ascot', 'Ascot är butiken för dig som prioriterar kvalitet, mode och service av högsta klass. \r\n\r\nHos oss hittar Du ett handplockat sortiment från starka och ledande varumärken. Hyllorna är alltid välfyllda med det mesta i klädväg från våra leveratörer; GANT, Polo Ralph Lauren, Hugo Boss, Cavaliere, Eton, Oscar of Sweden, Amanda Christensen, Saddler m.fl. \r\n\r\nVälkommen in önskar Thomas, Helena, Lillan, Pontus och John'),
(3, 'Bikbok', ''),
(4, 'BRIXX', 'Brixx är den kompletta butiken för den modemedvetna mannen. Hos oss får du alltid bästa service och bemötande.\r\n\r\nFölj oss på Instagram och Facebook för att hålla dig uppdaterad med nyheter och erbjudanden.\r\n\r\nVälkommen!'),
(5, 'Carlings', ''),
(6, 'Cotton & Steel', 'Livstilsbutik med cool inredning och snygga kläder. Här blir du alltid bjuden på kaffe och har du vovve behöver du inte binda den utanför.\r\nVarmt välkommen!'),
(7, 'Cubus', 'Cubus är en av Skandinaviens ledande modekedjor som erbjuder en prisvärd kollektion med trendig design av hög kvalitet. Spännande nyheter varje vecka gör butikerna levande och moderiktiga.\r\n\r\nEtt brett sortiment av accessoarer och kosmetik tillför det lilla extra.\r\n\r\nVälkommen in och låt dig inspireras hos Cubus!'),
(8, 'Diiza Fashion', 'Hos Diiza Fashion hittar du ett varierat sortiment av damkläder för både vardag och fest – såväl praktiska basplagg som trendiga toppar, kjolar, byxor och accessoarer.'),
(9, 'Dressmann', ''),
(10, 'Fanny', ''),
(11, 'Fico', 'Fico grundades 2005 av två modeslavar som ville tillföra en högre modegrad till Gävle. Med designutbildning och erfarenheter från både wholesale och retail lyckades man med konststycket att starta en fashionbutik i Gävle.\r\n\r\nFicos grundtanke var redan från starten att erbjuda både killar och tjejer märken som fokuserar på bra kvalité och fantastisk design. Märken som man inte ser i varje butik. Fico köper hellre ett litet märke med enorm kreativitet än ett större mainstream märke.\r\n\r\nFico har en specifik smak och du hittar ofta plagg från vissa märken som du aldrig tidigare sett. Man märker också att skandinavisk design är tongivande i butiken.\r\n\r\nWith love\r\nFico'),
(12, 'Flash', ''),
(13, 'Gant', ''),
(14, 'H&M', ''),
(15, 'Indiska Magasinet AB', 'INDISKA är en svensk familjeägd butikskedja etablerad 1901 som säljer en unik mix av mode och inredning med en egen stil. Allt designat i Stockholm av människor som älskar Indien. INDISKA har idag 98 butiker i Sverige, Norge, Finland, Island samt Shop Online.'),
(16, 'Intersport', 'INTERSPORT, ett av Sveriges mest kända varumärken, bildades 1961 och har 53 års erfarenhet av att vara närmast fotbollsplanen, hockeyrinken och löparbanan. INTERSPORT har Sveriges i särklass bredaste butiksnät med över 150 butiker och oerhört duktiga medarbetare som brinner för sport och träning. Vår vision är att svenskarna ska bli det mest aktiva folket i världen och vår mission är att inspirera fler till ett aktivt liv.\r\n\r\n \r\n\r\n2013 omsatte de svenska INTERSPORT-butikerna 4,1 miljarder kronor inklusive moms. INTERSPORT Sverige AB ingår i IIC – INTERSPORT International Corporation, vilket är världens största sportkedja med fler än 5 500 butiker i 43 länder. INTERSPORT finns förutom i Europa, inklusive Ryssland, även i Kanada och Förenade Arabemiraten. Under 2013 omsatte INTERSPORT cirka 10,6 miljarder euro globalt.\r\n\r\n \r\n\r\nIdén till INTERSPORT föddes 1961. En inköpsgruppering, ”Sport-tian” i Stockholm, kallade sportfackhandlare till ett möte för att diskutera hur man skulle klara konkurrensen från varuhusen som vid den tiden öppnades på flera håll. Resultatet blev Sportsam Ekonomisk Förening. 1974 bildades bolaget INTERSPORT Sverige AB.'),
(17, 'Jeansbolaget', ''),
(18, 'Joy', ''),
(19, 'Kalas & Co', 'Maskerad och kalasbutik som har allt från peruker till unika maskeradkläder för både försäljning och uthyrning. Vi utför även ansiktsmålningar, säljer smink, linser, skämtartiklar, dukningar och mycket mer. Butiken som ligger 1 tr ned i Gallerian Nian. Under oktober och Halloween råder galen aktivitet i butiken! Dessutom har vi ett underbart stort utbud av ballonger. Köp på lösvikt eller få dem fyllda med helium! Vi gör även ballongdekoration på plats hos såväl privatperson som hos företag.\r\n\r\nDet går även bra att boka oss för event. Vi kommer till dig och sjunger (bröllop, fest mm) leder barnkaraoke, ansiktsmålar på kalas och mycket mer!\r\n\r\nVälkommen in året om till Södra Norrlands roligaste och trevligaste Kalas o festbutik!'),
(20, 'KappAhl', 'KappAhl är en ledande modekedja med över 380 butiker och 4 900 medarbetare i Sverige, Norge, Finland, Polen och Tjeckien. Vi säljer prisvärt mode för många människor – kvinnor, män och barn. Egna designers formger alla plagg.'),
(21, 'Kriss', ''),
(22, 'Lindex', 'Dammode, underkläder och barnkläder.'),
(23, 'MM SPORTS, Gävle', 'MM Sports erbjuder ett brett sortiment av kosttillskott, träningskläder och tillbehör från de ledande märkena.\r\n\r\nHos oss får ni hjälp och råd kring vilka kosttillskott som passar just er och erat behov.\r\n\r\nOavsett om ni tränar på elitnivå, är vardagsmotionär eller bara vill ha hjälp med att komma i gång med en sundare livsstil, så är ni alltid välkomna in till oss!'),
(24, 'MQ', 'På MQ drivs vi av lusten att välja ut det bästa av stil och mode för man och kvinna. Vi finns till hands för en modeintresserad publik, och är en destination som sedan 1957 har hjälpt människor att hitta sin stil. Vår filosofi bygger på vad vi kallar ”Selected diversity” – Vilket betyder att vi befinner oss i den spännande kontrasten mellan utvalt och mångsidigt. Utvalt, för att vi ställer höga krav på vad som är bra nog för att hamna i våra butiker. Mångsidigt, för att vi trivs i en mix av kvalitetsvarumärken och starka personligheter. Vi vet att olika tillfällen kräver olika utryck. Vi finns här för att hjälpa dig som vill klä dig med stil, i vardag såväl som till fest. Alltid, och överallt.'),
(25, 'NATURKOMPANIET', 'Naturkompaniet i Gävle är butiken för den som ska ut på fjället, resa jorden runt, promenera i skog och mark eller bara ta en promenad med hunden i regnrusket. Vi hjälper dej att hitta rätt produkter för just dina behov. Vårt breda produktsortiment täcker in prylar och kläder för hela familjen, även små barn. Som officiell Vasaloppsbutik har vi även ett stort utbud och kunskap inom längdskidåkning.  Även rullskidor och löparkläder för amatör som proffs.\r\n\r\nVälkommen in till oss!'),
(26, 'Peak Performance', ''),
(27, 'RAOUL HERRMODE', 'RAOUL HERRMODE har funnits på den Svenska marknaden sedan 1988 och vi är välkända för att kunna erbjuda ett brett sortiment av klassiska och moderna herrkläder. Vi har storlekar för alla män – vi har det du söker! Vi kan även erbjuda ”Mix and Match” med 100-tals olika tyger i kostym, kavaj och byxor.\r\n\r\nVi hälsar Dig varmt välkommen till våran butik, eller besök oss gärna på www.raoul.se'),
(28, 'REDRUM', ''),
(29, 'Seafun', 'Skateboard, Snowboard, Surf, Streetwear, Shoes m.m.\r\n\r\nLakai, Dvs, DC, Volcom, Rip Curl, Matix, Fox, Sweet, Neff, Nomis, 686, ThirtyTwo, Douche, Circa, ZooYork, Dragon, EFX, Nike 6.0, Appertiff, Nikita, Bones, Santa Cruz, Nitro,K2, Lib-Tech m.m.\r\n\r\nVälkommen!'),
(30, 'Sivi Shop', 'Välkommen till Sivi Shop!\r\n\r\nSivi Shop startades 1965, och drivs av Britt-Inger Lindh.\r\n\r\nVårt sortiment innehåller märkeskläder från bl.a. Odd Molly, Hunky Dory, Gant, och Ugg.\r\n\r\nPersonlig service och hög kvalitet är våra ledord.\r\n\r\nNi hittar oss på Drottninggatan 22 i Gävle, i ”Stadshuset”.'),
(31, 'Söders Under', 'Söders Under!\r\n\r\nVälkommen till Gävles nyaste underklädesbutik med ett brett utbud av underkläder som passar både mogen kvinnor och unga tjejer med stor byst. Naturligtvis finns ett herrsortiment med kalsonger för den manliga kunden.\r\n\r\nSöders Under erbjuder alltid kunden att registrera sina storlekar för att underlätta för anhöriga att köpa presenter.\r\n\r\nFörutom underkläder finns strumpor, nattplagg och badkläder.\r\n\r\nVarmt välkommen in och prova önskar Josefin'),
(32, 'Stass', ''),
(33, 'Strumpan', ''),
(34, 'Stuff 4 Kids', 'Stuff 4 Kids i Gävle slog upp dörrarna i september 2009 efter flera månaders förberedelser och planering. Målet var att skapa en välsorterad butik för alla med barn, där man inte bara skulle kunna köpa barnkläder, utan även presenter och leksaker.\r\n\r\nJag som driver företaget heter Catrin Odby och arbetar själv i butiken.\r\nTillsammans med min anställda butikspersonal gör jag mitt bästa för att hjälpa er som kommer hit, så att ni kan hitta precis de kläder eller presenter ni söker.'),
(35, 'Tant Gredelin', ''),
(36, 'Twilfit', 'Vi på Twilfit är experter på underkläder och att hitta rätt passform och bekväma bh:ar samt underkläder.\r\n\r\nVi har även nattkollektion i olika material och utseenden.\r\nFrån alla åldrar är man välkommen in hos oss och vi hjälper kunderna från deras behov och tycke!\r\n\r\n'),
(37, 'Vero Moda', ''),
(38, 'Actic', ''),
(39, 'Always fitness', ''),
(40, 'Cykel o Sportverkstan', 'Företaget med många strängar på sin lyra från försäljning Cyklar Lapierre Batavius till reparation av hockey utrustning till Bauer Reebok med flera märken. Även storsortering på konstånings utrustnig skridskor Graf Wifa Edea mf.även tillbehör.Reparationer Cyklar Tält Båtkapell Ridutrstning (tyglar sadelgjord) fråga så får ni veta mera\r\n\r\nVälkomna\r\n\r\nDet omöjliga gör vi omgånde underverk tar något längre tid .'),
(41, 'Depeschen', ''),
(42, 'Gävle bowlinghall', 'Bowlinghallen mitt i Gävle centrum'),
(43, 'Gävle Idrottsbingo AB', 'Gävle Idrottsbingo AB driver, på uppdrag av Gävle Bingoallians, två bingohallar i Gävle.\r\n\r\nDen största bingohallen är Brynäsbingon, Norra Kungsgatan 3, där spelas traditionell bingo på pappersbrickor, Bingo på terminaler samt Vegas (5 maskiner).  Brynäsbingon utsågs av Svenska Spel till Årets Vegas Bingohall 2011 i Sverige.\r\n\r\nDen andra hallen är GIF-bingon på Hattmakargatan 6 B en modern bingohall, som är helt datoriserad med spel på dataterminaler. Spelen är vanlig terminalbingo samt Vegas (4 maskiner).  GIF-bingon utsågs av  Svenska till Årets Vegas Bingohall 2013 i Sverige. Tänk på att du måste vara 18 år för att få spela och vistas i våra lokaler.\r\n\r\nBeskrivning\r\n\r\nIdagsläget finns det ca 70 bingohallar i Sverige, från Kiruna i norr till Malmö i söder. Samtliga hallar har ideella föreningar som förmånstagare och drivs oftast av serviceföretag som består av flera föreningar eller enskilda näringsidkare. Serviceföretag i Gävle är Gävle Idrottsbingo AB, ett bolag som ägs till 50% av Brynäs IF Hockey och 50% av Gefle IF Alliansförening.\r\n\r\nBingotillståndet administreras av Gävle Bingoallians, vars nuvarande bingotillstånd gäller för perioden 2016-01-01 — 2017-12-31, med sina medlemsföreningar i Gävle. Gävle Bingoallians har en styrelse som följer verksamheten vid våra bingohallar. Hela det ekonomiska överskottet från vår verksamhet fördelas mellan föreningarna i alliansen. Det är storleken på föreningens ungdomsverksamhet som ligger till grund för hur stor del av avkastningen varje förening får. Ju fler ungdomar som deltar i föreningens verksamhet, desto mer pengar till föreningen.\r\n\r\nLänsstyrelsen är vår tillsynsmyndighet och den som utfärdar lotteritillstånd, sköter kontrollen, beslutar vilka föreningar som får vara förmånstagare och godkänner avtal. Bingohallarna delar ut stora belopp varje år direkt till det lokala föreningslivet, dessa pengar har varit – och är – avgörande för många föreningars överlevnad.\r\n\r\nUtöver det traditionella bingospelet förekommer det även spel på så kallade värdeautomater i de flesta bingohallar. Detta sker i samarbete med Svenska Spel och tillsynsmyndigheten Lotteriinspektionen, vilket garanterar att kontrollen på automatspelet är lika bra som på bingospelet.\r\n\r\nDen traditionella bingon står dock för huvuddelen av den totala omsättningen.  Allt överskott går oavkortat till föreningslivet i Gävle.\r\n\r\nGävle Bingo en viktig del av föreningslivet i Gävle kommun.'),
(44, 'Må Bättre', 'Träning är för alla, och den bästa träningen är den som blir av. Hos oss finns alternativen för dig som redan insett värdet av regelbunden träning, men som vill ta din träning till nya nivåer. Merparten av de som är medlemmar hos oss idag, hade dock aldrig tränat innan de kom till Må Bättre.\r\n\r\nVår grundfilosofi är att inspirera människor till att uppnå livskvalitet och hälsa. Vi riktar oss till både privatpersoner och företag som värdesätter hög kvalitet och personlig service.\r\n\r\nVi som driver Må Bättres friskvårdsanläggningar tror starkt på den helhet som vi levererar till våra kunder. Vi strävar också efter att ge våra medlemmar det allra senaste inom träning, kost och friskvård. En motiverande miljö och ett brett aktivitetsutbud ger stor valfrihet och variation när det kommer till friskvård.\r\n\r\nMå Bättre startades år 2000 i Falun och finns nu på ett flertal platser, främst i Dalarna. \r\n\r\nHjärtligt välkommen till oss!'),
(45, 'Söders källa', 'Söders Källa är ett centralt beläget företag i Gävle som erbjuder allt inom konferens, evenemang, restaurang samt gym och yoga.\r\n\r\nVi har stora fräscha lokaler med modern utrustning för konferenser, musik, show, föreläsningar och presentationer. Vår fina restaurang ligger i direkt anslutning till lokalerna där det serveras lunch samt middag.\r\nEn trappa ner ligger vårt gym med gruppträning och personlig träning.\r\nPå övervåningen hyrs rum ut till kiropraktor, osteopat samt massörer.'),
(46, 'Stadium', '”Join the movement”'),
(47, 'Zone', ''),
(48, 'Alida skor', ''),
(49, 'Berglunds Skor', 'Skobutiken med ett brett urval av skor för hela familjen!\r\n\r\nVi brinner för kvalitet, former och personlig service. Vår kärlek till skor tillsammans med lång erfarenhet och kunskap gör att vi kan garantera det bästa urvalet för hela familjen från de främsta leverantörerna.\r\n\r\nSortimentet består av de skor en familj behöver för både inom- och utomhusbruk. Barnskor för de yngsta, trendigt för de modemedvetna, sköna promenadskor för de som är på språng.\r\n\r\nVåra skor står för kvalitet, känsla och form. Berglunds Skor finns även i Söderhamn, Bollnäs, Ljusdal och Hudiksvall. Vi har därför möjlighet att beställa din storlek av en sko från någon av de andra butikerna om den är slut hos oss i Gävle och då finns den i butik inom några dagar.\r\n\r\nVälkommen in till oss för att träffa specialisterna och beundra ett brett skosortiment!'),
(50, 'Din Sko', 'På DinSko hittar du aktuella skor för alla stilar som passar dig och den du är, just här, just nu. Här finns allt för en trendig vardag eller en glittrande festkväll. Vår övertygelse är att rätt skor kan förändra och lyfta en hel look.\r\n\r\nVi på DinSko inspireras av dagens trender och erbjuder prisvärda skor för en modemedveten publik. I våra butiker finns alltid ett brett dam- och herrsortiment för många olika behov. Dessutom har vi massor av fina samt funktionella barnskor för både skola och fritid. Vår engagerade och kunniga personal guidar dig till rätt köp som passar din personliga stil. Det senaste skomodet väntar på dig hos DinSko!\r\nUpdate your Shoedrobe!\r\n\r\nShop online at dinsko.com\r\n\r\n \r\n\r\nDinSko är en del av Skandinaviens största skokoncern NilsonGroup. Tillsammans med butikskoncepten Nilson Shoes, Skopunkten, Jerns samt franchisebaserade Ecco Stores erbjuder koncernen ett oslagbart utbud i kombination med starka varumärken.'),
(51, 'Ecco', 'Nilson group har ett långt och framgångsrikt samarbete tillsammans med ECCO.\r\n\r\nDet startade redan på 1960- talet under uppbyggnaden av ECCO, som i dag är ett av världens mest kända varumärken.\r\n\r\nFranchisebaserade Ecco Stores drivs av Nilsongroup både som separata butiker och som shop in shop i Sverige och Norge.\r\n\r\n \r\n\r\nMed produkten i fokus och med ledord som komfort, funktion och kvalitet skapar ECCO kvalitetsinriktad design som kombinerar bekväma skor med ett attraktivt utseende.\r\n\r\n \r\n\r\nProduktutveckling är en mycket viktig del i arbetsflödet, där ECCO lägger stor vikt vid ta fram nya tekniker för att kunna erbjuda ännu mjukare och mer flexibla skor. ECCO är dessutom en av världens största skinnproducenter som därmed har full delaktighet i hela tillverkningsprocessen, från första garvtaget till färdig sko ut i butik. ECCO strävar alltid efter att leverera elegant enkelhet av högsta kvalitet, klassiska former och tidlös stil som alltid står sig.\r\n\r\nVälkommen in till oss i vår butik i Gallerian Nian!'),
(52, 'Fot & Skospecialisten i Gävle', 'Fot & Sko Gävle är en unik butik. Vi är en välsorterad butik med skor för alla behov. Det kan vara för promenader, jogging eller arbete, för inomhus- eller utomhusbruk. Du kan även få hjälp med besvär från rörelse- och stödjeapparaten (leder, muskler och nerver). Vårt koncept bygger på ett helhetstänk, vi tittar inte bara på dina fötter utan erbjuder en komplett funktionsanalys.\r\n\r\nEtt felaktigt belastningsmönster kan orsaka många typer av besvär i exempelvis knä, höft och rygg. Är fotbesvären orsaken till smärtan i knä, höft och rygg? Eller är det besvären från ex ryggen eller höften som ger smärtan i foten? Vi är specialiserade på att analysera detta och vilken typ av behandling eller åtgärd som är den bästa för dig.\r\nVi arbetar med ortopediska/podiatriska fotinlägg. Vi har professionella standardinlägg och gör även individuella efter gipsavgjutningar.\r\n\r\nVi har ett eget ortopedtekniskt lab och all tillverkning sker hos oss, i alla led i våra lokaler på Söder i Gävle. Vi kan därför garantera kvaliteten i hela produktionsledet, från undersökning till färdiga fotinlägg.  Vårt mål är att ge dig hjälp på absolut högsta nivå.'),
(53, 'Scorett', 'Scorett är en av Sveriges ledande detaljistkedjor inom skor. Scorett bildades som en frifackkedja 1989. Scorettkedjan har expanderat kraftigt de senaste åren och idag finns ca 80 Scorettbutiker och 5 outlets över hela Sverige. Huvudkontoret ligger på västkusten i skostaden Varberg. Här arbetar designers, inköpare och assistenter med att ständigt följa trender och till varje säsong ta fram ett attraktivt sortiment med hög kvalitet till bra priser.\r\n\r\nScorett erbjuder ett stort utbud av egna och externa varumärken. Scorett vänder sig till mode- och kvalitetsmedvetna skoälskare. För att ge de bästa kunderna extra förmåner har Scorett en kundklubb som heter Solemate. Sedan 2011 finns Scorett även som e-handel.\r\n\r\nScorett vänder sig till mode- och kvalitetsmedvetna skoälskare!'),
(54, 'Skomakarna Södran', 'Välkommen till Skomakarna på Söder! \r\nGrundat 1932 av K. Edv. Forsberg\r\n\r\nVi utför dagligen skoreparationer & nyckelservice. Vi lagar dessutom jackor, byxor, väskor m.m.\r\n\r\nI vår butik finner du väskor, skovård, nyckeltillbehör, skosnören, skinn och mycket mer!\r\n\r\nVi är även ombud åt Gävletvätten.'),
(55, 'Skopunkten', 'På Skopunkten finns hela familjens behov av skor samlat på ett ställe. Priserna är låga och hos oss är\r\ndet extra förmånligt att handla fler par på samma gång. Vi har alltid våra erbjudanden ”Välj 3 Betala 2\r\n– Billigaste paret på köpet” samt ”Välj 2 – Billigaste paret halva priset”. Detta gör att de flesta kunder\r\nofta handlar mer än ett par. Det är enkelt att handla på Skopunkten! Helpar i butik, gott om plats, tydlig\r\nkommunikation, snabbt att betala. Modernt, men framför allt funktionellt, både för kunder och personal.\r\nSkopunkten ingår i Skandinaviens största skokoncern NilsonGroup, tillsammans med butikskoncepten\r\nDinSko, Nilson Shoes, Jerns samt franchisebaserade Ecco Stores.'),
(56, 'Apple Demo', ''),
(57, 'Glitter', 'Glitter erbjuder kvinnor i alla åldrar ett brett sortiment av prisvärda modesmycken och accessoarer i kombination med personlig service. Vi är specialister på styling och har förslag på hur man med små medel kan förstärka den personliga stilen.'),
(58, 'Guldfynd', ''),
(59, 'KICKS', ''),
(60, 'Klockmaster', 'Klockmaster med allt från klassiskt till det senaste modet.\r\n\r\nServiceverkstad som servar din klocka vid alla tillfällen.'),
(61, 'Kriss', ''),
(62, 'Smyckevalvet by Anna Danielsson', 'Hos Smyckevalvet finner du smycken från Anna Danielssons kollektioner i äkta silver och 18k guld. Många av smyckena är tillverkade på plats i ateljéns verkstad. Här finns även vigsel- och förlovningsringar som tillverkas utifrån dina önskemål. Du kan även välja bland modeller från bla Schalins Ringar, Guldbolaget och Flemming Uziel. I ateljén finner du även smycken från kända designers som tex Edblad, Bronzallure, Lite kalabalik och Wingman.'),
(63, '', '');

-- --------------------------------------------------------

--
-- Tabellstruktur `partner_coupons`
--

DROP TABLE IF EXISTS `partner_coupons`;
CREATE TABLE IF NOT EXISTS `partner_coupons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE latin1_bin NOT NULL,
  `description` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

--
-- Dumpning av Data i tabell `partner_coupons`
--

INSERT INTO `partner_coupons` (`id`, `title`, `description`) VALUES
(1, 'Naked juice bar', '25% rabatt på valfria smoothies hos ”Naked juice bar”.'),
(2, 'Naked juice bar', '5% rabatt på valfria smoothies hos ”Naked juice bar”.'),
(3, 'Naked juice bar', '50% rabatt på valfria smoothies hos ”Naked juice bar”.');

-- --------------------------------------------------------

--
-- Tabellstruktur `server_information`
--

DROP TABLE IF EXISTS `server_information`;
CREATE TABLE IF NOT EXISTS `server_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `text` varchar(255) NOT NULL,
  `added` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumpning av Data i tabell `server_information`
--

INSERT INTO `server_information` (`id`, `title`, `text`, `added`) VALUES
(1, 'Nyheter', 'Nyhet här... ', '2018-06-18');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
