-- Austin Places Seed Script
-- 30 restaurants, 30 bars, 30 bakeries
--
-- NOTE: google_place_id values are placeholders. Replace each one with the
--       real Google Place ID from the Places API before running in production.
--
-- NOTE: This script inserts a seed admin user to satisfy the submitted_by FK.
--       If a seed user already exists, remove that block and set
--       submitted_by = <real user id> throughout.

BEGIN;

-- Seed admin user (skipped if already present)
INSERT INTO users (discord_handle, google_id, has_lifetime_access, is_current_server_member)
VALUES ('seed_admin', 'seed_admin_google_id', TRUE, TRUE)
ON CONFLICT (google_id) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- RESTAURANTS (30)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO places (name, lat, lng, formatted_address, google_place_id, type, submitted_by) VALUES
  ('Lutie''s Garden Restaurant', 30.3031, -97.7295, '4100 Red River St, Austin, TX 78751', 'ChIJLuties_GardenRest_ATX001', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Birdie''s', 30.2721, -97.7062, '2944 E 12th St, Austin, TX 78702', 'ChIJBirdiesRestaurant_ATX002', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Dai Due', 30.2798, -97.7168, '2406 Manor Rd, Austin, TX 78722', 'ChIJDaiDueRestaurant__ATX003', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Franklin Barbecue', 30.2697, -97.7317, '900 E 11th St, Austin, TX 78702', 'ChIJFranklinBBQ______ATX004', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Nixta Taqueria', 30.2718, -97.7057, '2512 E 12th St, Austin, TX 78702', 'ChIJNixtaTaqueria____ATX005', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Spicy Boys', 30.2665, -97.7237, '1701 E 6th St, Austin, TX 78702', 'ChIJSpicyBoysATX_____ATX006', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('June''s All Day', 30.2436, -97.7527, '1722 S Congress Ave, Austin, TX 78704', 'ChIJJunesAllDay______ATX007', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Barley Swine', 30.3328, -97.7322, '6555 Burnet Rd, Austin, TX 78757', 'ChIJBarleySwine______ATX008', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Bird Bird Biscuit', 30.2805, -97.7132, '2701 Manor Rd, Austin, TX 78722', 'ChIJBirdBirdBiscuit__ATX009', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Jewboy Burgers', 30.3198, -97.7214, '5111 Airport Blvd, Austin, TX 78751', 'ChIJJewboyBurgers____ATX010', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Better Half', 30.2699, -97.7648, '406 Walsh St, Austin, TX 78703', 'ChIJBetterHalfATX____ATX011', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('LeRoy And Lewis', 30.2220, -97.8019, '5621 Emerald Forest Dr, Austin, TX 78745', 'ChIJLeRoyAndLewis____ATX012', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Homeslice Pizza', 30.2518, -97.7571, '1415 S Congress Ave, Austin, TX 78704', 'ChIJHomeslicePizza___ATX013', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Ramen Tatsu-ya', 30.2669, -97.7224, '1600 E 6th St, Austin, TX 78702', 'ChIJRamenTatsuya_____ATX014', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Uchiko', 30.3148, -97.7441, '4200 N Lamar Blvd, Austin, TX 78756', 'ChIJUchikoRestaurant_ATX015', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Cuantos Tacos', 30.2714, -97.7312, '1108 E 12th St, Austin, TX 78702', 'ChIJCuantosTacos_____ATX016', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Hestia', 30.2661, -97.7528, '607 W 3rd St, Austin, TX 78701', 'ChIJHestiaRestaurant_ATX017', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Bufalina Due', 30.3329, -97.7323, '6555 Burnet Rd, Austin, TX 78757', 'ChIJBufalinaDue______ATX018', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Lenoir', 30.2510, -97.7571, '1807 S 1st St, Austin, TX 78704', 'ChIJLenoirRestaurant_ATX019', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Fonda San Miguel', 30.3278, -97.7518, '2330 W North Loop Blvd, Austin, TX 78756', 'ChIJFondaSanMiguel___ATX020', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Olamaie', 30.2758, -97.7459, '1610 San Antonio St, Austin, TX 78701', 'ChIJOlamaieRestaurant_ATX021', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Little Deli & Pizzeria', 30.3401, -97.7218, '4005 Medical Pkwy, Austin, TX 78756', 'ChIJLittleDeliPizzeria_ATX022', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Clark''s Oyster Bar', 30.2724, -97.7598, '1200 W 6th St, Austin, TX 78703', 'ChIJClarksOysterBar__ATX023', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Lin Asian Bar', 30.2725, -97.7599, '1203 W 6th St, Austin, TX 78703', 'ChIJLinAsianBar______ATX024', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Suerte', 30.2668, -97.7229, '1800 E 6th St, Austin, TX 78702', 'ChIJSuerteRestaurant_ATX025', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Maie Day', 30.2477, -97.7522, '1603 S Congress Ave, Austin, TX 78704', 'ChIJMaieDay__________ATX026', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Comedor', 30.2652, -97.7456, '501 Colorado St, Austin, TX 78701', 'ChIJComedorRestaurant_ATX027', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Emmer & Rye', 30.2581, -97.7387, '51 Rainey St, Austin, TX 78701', 'ChIJEmmerAndRye______ATX028', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Interstellar BBQ', 30.4461, -97.8297, '12233 Ranch Rd 620 N, Austin, TX 78750', 'ChIJInterstellarBBQ__ATX029', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Bulevar', 30.4019, -97.7591, '9400 Arboretum Blvd, Austin, TX 78759', 'ChIJBulevarRestaurant_ATX030', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id'));

-- ─────────────────────────────────────────────────────────────────────────────
-- BARS (30)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO places (name, lat, lng, formatted_address, google_place_id, type, submitted_by) VALUES
  ('Small Victory', 30.2677, -97.7423, '108 E 7th St, Austin, TX 78701', 'ChIJSmallVictoryBar__ATX031', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Midnight Cowboy', 30.2668, -97.7422, '313 E 6th St, Austin, TX 78701', 'ChIJMidnightCowboy___ATX032', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Firehouse Lounge', 30.2692, -97.7400, '605 Brazos St, Austin, TX 78701', 'ChIJFirehouseLounge__ATX033', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Higher Ground', 30.2709, -97.7423, '720 Congress Ave, Austin, TX 78701', 'ChIJHigherGroundBar__ATX034', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('The Driskill Bar', 30.2691, -97.7401, '604 Brazos St, Austin, TX 78701', 'ChIJDriskillBar______ATX035', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Friends Bar', 30.2668, -97.7433, '409 E 7th St, Austin, TX 78701', 'ChIJFriendsBarATX____ATX036', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Lavaca Street Bar', 30.2668, -97.7453, '405 Colorado St, Austin, TX 78701', 'ChIJLavacaStreetBar__ATX037', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Seven Grand', 30.2678, -97.7418, '405 E 7th St, Austin, TX 78701', 'ChIJSevenGrandBar____ATX038', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Edge Rooftop', 30.2641, -97.7421, '110 E 2nd St, Austin, TX 78701', 'ChIJEdgeRooftopBar___ATX039', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Donn''s Depot', 30.2730, -97.7681, '2400 San Antonio St, Austin, TX 78705', 'ChIJDonnsDepotBar____ATX040', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Frazier''s Long & Low', 30.2268, -97.7267, '6607 N Lamar Blvd, Austin, TX 78752', 'ChIJFraziersLongLow__ATX041', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Cheer Up Charlies', 30.2689, -97.7367, '900 Red River St, Austin, TX 78701', 'ChIJCheerUpCharlies__ATX042', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Nickel City', 30.2703, -97.7296, '905 W 6th St, Austin, TX 78703', 'ChIJNickelCityBar____ATX043', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('The Roosevelt Room', 30.2666, -97.7491, '307 W 5th St, Austin, TX 78701', 'ChIJRooseveltRoomBar_ATX044', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Daydreamer', 30.2668, -97.7235, '1800 E 6th St, Austin, TX 78702', 'ChIJDaydreamerBar____ATX045', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Tiki Tatsu-Ya', 30.2622, -97.7746, '7308 N Lamar Blvd, Austin, TX 78752', 'ChIJTikiTatsuYaBar___ATX046', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Whisler''s', 30.2668, -97.7229, '1816 E 6th St, Austin, TX 78702', 'ChIJWhislersBar______ATX047', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Armadillo Den', 30.1881, -97.8359, '10106 Manchaca Rd, Austin, TX 78748', 'ChIJArmadilloDenBar__ATX048', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Equipment Room', 30.2459, -97.7527, '820 Congress Ave, Austin, TX 78701', 'ChIJEquipmentRoomBar_ATX049', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Murray''s Tavern', 30.2588, -97.6971, '5130 Burnet Rd, Austin, TX 78756', 'ChIJMurraysTavernBar_ATX050', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Here Nor There', 30.2693, -97.7399, '307 E 8th St, Austin, TX 78701', 'ChIJHereNorThereBar__ATX051', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Lala''s Little Nugget', 30.3431, -97.7232, '5403 N Lamar Blvd, Austin, TX 78751', 'ChIJLalasLittleNugget_ATX052', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Holiday', 30.2631, -97.6928, '5020 E 7th St, Austin, TX 78702', 'ChIJHolidayBarATX____ATX053', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('The White Horse', 30.2662, -97.7223, '500 Comal St, Austin, TX 78702', 'ChIJWhiteHorseBar____ATX054', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('The Little Darlin''', 30.2198, -97.8022, '3016 S Congress Ave, Austin, TX 78704', 'ChIJLittleDarlinBar__ATX055', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Yellow Jacket Social Club', 30.2658, -97.7235, '1704 E 5th St, Austin, TX 78702', 'ChIJYellowJacketBar__ATX056', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Kitty Cohen''s', 30.2580, -97.6968, '2211 Webberville Rd, Austin, TX 78702', 'ChIJKittyCohensBar___ATX057', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('The Continental Club', 30.2484, -97.7508, '1315 S Congress Ave, Austin, TX 78704', 'ChIJContinentalClub__ATX058', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Banger''s Sausage House & Beer Garden', 30.2582, -97.7388, '79 Rainey St, Austin, TX 78701', 'ChIJBangersBeerGarden_ATX059', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Antone''s Nightclub', 30.2653, -97.7431, '305 E 5th St, Austin, TX 78701', 'ChIJAntonesNightclub_ATX060', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id'));

-- ─────────────────────────────────────────────────────────────────────────────
-- BAKERIES (30)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO places (name, lat, lng, formatted_address, google_place_id, type, submitted_by) VALUES
  ('1886 Cafe & Bakery', 30.2691, -97.7402, '604 Brazos St, Austin, TX 78701', 'ChIJ1886CafeBakery___ATX061', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Capital City Bakery', 30.2564, -97.7205, '2211 E Cesar Chavez St, Austin, TX 78702', 'ChIJCapitalCityBakery_ATX062', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('La Patisserie', 30.2448, -97.7577, '602 W Annie St, Austin, TX 78704', 'ChIJLaPatisserie_____ATX063', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Sugar Mama''s Bakeshop', 30.2508, -97.7571, '1401 S Lamar Blvd, Austin, TX 78704', 'ChIJSugarMamasBake___ATX064', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Quack''s 43rd Street Bakery', 30.3019, -97.7266, '411 E 43rd St, Austin, TX 78751', 'ChIJQuacks43rdBakery_ATX065', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Rocheli Patisserie', 30.2699, -97.7281, '1700 E 6th St, Austin, TX 78702', 'ChIJRocheliPatisserie_ATX066', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Nate''s Baked Goods & Coffee', 30.2788, -97.7635, '401 Orchard St, Austin, TX 78703', 'ChIJNatesBakedGoods__ATX067', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Lady Quackenbush''s Cakery', 30.2828, -97.6891, '5505 N Lamar Blvd, Austin, TX 78751', 'ChIJLadyQuackenbush__ATX068', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Comadre Panaderia', 30.2690, -97.7358, '2219 S 1st St, Austin, TX 78704', 'ChIJComadrePanaderia_ATX069', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Rockman Coffee + Bakeshop', 30.2571, -97.7181, '1614 E 12th St, Austin, TX 78702', 'ChIJRockmanBakeshop__ATX070', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Peace Bakery and Deli', 30.4067, -97.7211, '4006 N Lamar Blvd, Austin, TX 78756', 'ChIJPeaceBakeryDeli__ATX071', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Sour Duck Market', 30.2789, -97.7138, '1814 E Martin Luther King Jr Blvd, Austin, TX 78702', 'ChIJSourDuckMarket___ATX072', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Epicerie', 30.3238, -97.7571, '2304 Lake Austin Blvd, Austin, TX 78703', 'ChIJEpicerieBakery___ATX073', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Mi Tradicion', 30.3781, -97.7206, '11601 N Lamar Blvd, Austin, TX 78753', 'ChIJMiTradicionBakery_ATX074', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Tiny Pies', 30.3228, -97.7322, '5035 Burnet Rd, Austin, TX 78756', 'ChIJTinyPiesBakery___ATX075', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('OMG Squee', 30.2845, -97.6962, '2406 Manor Rd, Austin, TX 78722', 'ChIJOMGSqueeBakery___ATX076', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Batch Craft Beer & Kolaches', 30.2818, -97.6943, '4005 Medical Pkwy, Austin, TX 78756', 'ChIJBatchKolaches____ATX077', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Easy Tiger Linc', 30.3428, -97.7208, '6432 N Lamar Blvd, Austin, TX 78752', 'ChIJEasyTigerLinc____ATX078', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Pflour Shop', 30.3498, -97.7322, '512 W 29th St, Austin, TX 78705', 'ChIJPflourShopBakery_ATX079', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Tous les Jours', 30.3528, -97.7411, '6929 Airport Blvd, Austin, TX 78752', 'ChIJTousLesJours_____ATX080', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Upper Crust Bakery', 30.3148, -97.7323, '4805 Burnet Rd, Austin, TX 78756', 'ChIJUpperCrustBakery_ATX081', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('ThoroughBread', 30.2618, -97.7731, '7308 N Lamar Blvd, Austin, TX 78752', 'ChIJThoroughBread____ATX082', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Mercado Sin Nombre', 30.2758, -97.7182, '1906 E 12th St, Austin, TX 78702', 'ChIJMercadoSinNombre_ATX083', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Teal House Coffee & Bakery', 30.2958, -97.6911, '1910 E 12th St, Austin, TX 78702', 'ChIJTealHouseBakery__ATX084', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Swedish Hill Bakery', 30.2511, -97.7572, '1100 S Congress Ave, Austin, TX 78704', 'ChIJSwedishHillBakery_ATX085', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Elizabeth Street Cafe', 30.2519, -97.7571, '1104 S Lamar Blvd, Austin, TX 78704', 'ChIJElizabethStCafe__ATX086', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Walton''s Fancy & Staple', 30.2718, -97.7598, '609 W 6th St, Austin, TX 78701', 'ChIJWaltonsFancyStapl_ATX087', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('The Salty Donut', 30.2441, -97.7521, '2000 S Congress Ave, Austin, TX 78704', 'ChIJSaltyDonutATX____ATX088', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Texas French Bread', 30.2898, -97.7498, '2900 Rio Grande St, Austin, TX 78705', 'ChIJTexasFrenchBread_ATX089', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Sweetish Hill Bakery', 30.2724, -97.7698, '1120 W 6th St, Austin, TX 78703', 'ChIJSweetishHill_____ATX090', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id'));

COMMIT;
