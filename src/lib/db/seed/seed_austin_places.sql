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
INSERT INTO places (name, lat, lng, google_place_id, type, submitted_by) VALUES
  ('Lutie''s Garden Restaurant',      30.3031,  -97.7295, 'ChIJLuties_GardenRest_ATX001', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Birdie''s',                        30.2721,  -97.7062, 'ChIJBirdiesRestaurant_ATX002', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Dai Due',                          30.2798,  -97.7168, 'ChIJDaiDueRestaurant__ATX003', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Franklin Barbecue',                30.2697,  -97.7317, 'ChIJFranklinBBQ______ATX004', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Nixta Taqueria',                   30.2718,  -97.7057, 'ChIJNixtaTaqueria____ATX005', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Spicy Boys',                       30.2665,  -97.7237, 'ChIJSpicyBoysATX_____ATX006', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('June''s All Day',                  30.2436,  -97.7527, 'ChIJJunesAllDay______ATX007', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Barley Swine',                     30.3328,  -97.7322, 'ChIJBarleySwine______ATX008', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Bird Bird Biscuit',                30.2805,  -97.7132, 'ChIJBirdBirdBiscuit__ATX009', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Jewboy Burgers',                   30.3198,  -97.7214, 'ChIJJewboyBurgers____ATX010', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Better Half',                      30.2699,  -97.7648, 'ChIJBetterHalfATX____ATX011', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('LeRoy And Lewis',                  30.2220,  -97.8019, 'ChIJLeRoyAndLewis____ATX012', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Homeslice Pizza',                  30.2518,  -97.7571, 'ChIJHomeslicePizza___ATX013', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Ramen Tatsu-ya',                   30.2669,  -97.7224, 'ChIJRamenTatsuya_____ATX014', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Uchiko',                           30.3148,  -97.7441, 'ChIJUchikoRestaurant_ATX015', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Cuantos Tacos',                    30.2714,  -97.7312, 'ChIJCuantosTacos_____ATX016', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Hestia',                           30.2661,  -97.7528, 'ChIJHestiaRestaurant_ATX017', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Bufalina Due',                     30.3329,  -97.7323, 'ChIJBufalinaDue______ATX018', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Lenoir',                           30.2510,  -97.7571, 'ChIJLenoirRestaurant_ATX019', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Fonda San Miguel',                 30.3278,  -97.7518, 'ChIJFondaSanMiguel___ATX020', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Olamaie',                          30.2758,  -97.7459, 'ChIJOlamaieRestaurant ATX021', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Little Deli & Pizzeria',           30.3401,  -97.7218, 'ChIJLittleDeliPizzeri ATX022', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Clark''s Oyster Bar',              30.2724,  -97.7598, 'ChIJClarksOysterBar__ATX023', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Lin Asian Bar',                    30.2725,  -97.7599, 'ChIJLinAsianBar______ATX024', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Suerte',                           30.2668,  -97.7229, 'ChIJSuerteRestaurant_ATX025', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Maie Day',                         30.2477,  -97.7522, 'ChIJMaieDay__________ATX026', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Comedor',                          30.2652,  -97.7456, 'ChIJComedorRestaurant ATX027', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Emmer & Rye',                      30.2581,  -97.7387, 'ChIJEmmerAndRye______ATX028', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Interstellar BBQ',                 30.4461,  -97.8297, 'ChIJInterstellarBBQ__ATX029', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Bulevar',                          30.4019,  -97.7591, 'ChIJBulevarRestaurant ATX030', 'RESTAURANT', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id'));

-- ─────────────────────────────────────────────────────────────────────────────
-- BARS (30)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO places (name, lat, lng, google_place_id, type, submitted_by) VALUES
  ('Small Victory',                    30.2677,  -97.7423, 'ChIJSmallVictoryBar__ATX031', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Midnight Cowboy',                  30.2668,  -97.7422, 'ChIJMidnightCowboy___ATX032', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Firehouse Lounge',                 30.2692,  -97.7400, 'ChIJFirehouseLounge__ATX033', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Higher Ground',                    30.2709,  -97.7423, 'ChIJHigherGroundBar__ATX034', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('The Driskill Bar',                 30.2691,  -97.7401, 'ChIJDriskillBar______ATX035', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Friends Bar',                      30.2668,  -97.7433, 'ChIJFriendsBarATX____ATX036', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Lavaca Street Bar',                30.2668,  -97.7453, 'ChIJLavacaStreetBar__ATX037', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Seven Grand',                      30.2678,  -97.7418, 'ChIJSevenGrandBar____ATX038', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Edge Rooftop',                     30.2641,  -97.7421, 'ChIJEdgeRooftopBar___ATX039', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Donn''s Depot',                    30.2730,  -97.7681, 'ChIJDonnsDepotBar____ATX040', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Frazier''s Long & Low',            30.2268,  -97.7267, 'ChIJFraziersLongLow__ATX041', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Cheer Up Charlies',                30.2689,  -97.7367, 'ChIJCheerUpCharlies__ATX042', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Nickel City',                      30.2703,  -97.7296, 'ChIJNickelCityBar____ATX043', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('The Roosevelt Room',               30.2666,  -97.7491, 'ChIJRooseveltRoomBar_ATX044', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Daydreamer',                       30.2668,  -97.7235, 'ChIJDaydreamerBar____ATX045', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Tiki Tatsu-Ya',                    30.2622,  -97.7746, 'ChIJTikiTatsuYaBar___ATX046', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Whisler''s',                       30.2668,  -97.7229, 'ChIJWhislersBar______ATX047', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Armadillo Den',                    30.1881,  -97.8359, 'ChIJArmadilloDenBar__ATX048', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Equipment Room',                   30.2459,  -97.7527, 'ChIJEquipmentRoomBar_ATX049', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Murray''s Tavern',                 30.2588,  -97.6971, 'ChIJMurraysTavernBar_ATX050', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Here Nor There',                   30.2693,  -97.7399, 'ChIJHereNorThereBar__ATX051', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Lala''s Little Nugget',            30.3431,  -97.7232, 'ChIJLalasLittleNugget ATX052', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Holiday',                          30.2631,  -97.6928, 'ChIJHolidayBarATX____ATX053', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('The White Horse',                  30.2662,  -97.7223, 'ChIJWhiteHorseBar____ATX054', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('The Little Darlin''',              30.2198,  -97.8022, 'ChIJLittleDarlinBar__ATX055', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Yellow Jacket Social Club',        30.2658,  -97.7235, 'ChIJYellowJacketBar__ATX056', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Kitty Cohen''s',                   30.2580,  -97.6968, 'ChIJKittyCohensBar___ATX057', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('The Continental Club',             30.2484,  -97.7508, 'ChIJContinentalClub__ATX058', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Banger''s Sausage House & Beer Garden', 30.2582, -97.7388, 'ChIJBangersBeerGarden ATX059', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Antone''s Nightclub',              30.2653,  -97.7431, 'ChIJAntonesNightclub_ATX060', 'BAR', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id'));

-- ─────────────────────────────────────────────────────────────────────────────
-- BAKERIES (30)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO places (name, lat, lng, google_place_id, type, submitted_by) VALUES
  ('1886 Cafe & Bakery',               30.2691,  -97.7402, 'ChIJ1886CafeBakery___ATX061', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Capital City Bakery',              30.2564,  -97.7205, 'ChIJCapitalCityBakery ATX062', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('La Patisserie',                    30.2448,  -97.7577, 'ChIJLaPatisserie_____ATX063', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Sugar Mama''s Bakeshop',           30.2508,  -97.7571, 'ChIJSugarMamasBake___ATX064', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Quack''s 43rd Street Bakery',      30.3019,  -97.7266, 'ChIJQuacks43rdBakery_ATX065', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Rocheli Patisserie',               30.2699,  -97.7281, 'ChIJRocheliPatisserie ATX066', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Nate''s Baked Goods & Coffee',     30.2788,  -97.7635, 'ChIJNatesBakedGoods__ATX067', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Lady Quackenbush''s Cakery',       30.2828,  -97.6891, 'ChIJLadyQuackenbush__ATX068', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Comadre Panaderia',                30.2690,  -97.7358, 'ChIJComadrePanaderia_ATX069', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Rockman Coffee + Bakeshop',        30.2571,  -97.7181, 'ChIJRockmanBakeshop__ATX070', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Peace Bakery and Deli',            30.4067,  -97.7211, 'ChIJPeaceBakeryDeli__ATX071', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Sour Duck Market',                 30.2789,  -97.7138, 'ChIJSourDuckMarket___ATX072', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Epicerie',                         30.3238,  -97.7571, 'ChIJEpicerieBakery___ATX073', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Mi Tradicion',                     30.3781,  -97.7206, 'ChIJMiTradicionBakery ATX074', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Tiny Pies',                        30.3228,  -97.7322, 'ChIJTinyPiesBakery___ATX075', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('OMG Squee',                        30.2845,  -97.6962, 'ChIJOMGSqueeBakery___ATX076', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Batch Craft Beer & Kolaches',      30.2818,  -97.6943, 'ChIJBatchKolaches____ATX077', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Easy Tiger Linc',                  30.3428,  -97.7208, 'ChIJEasyTigerLinc____ATX078', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Pflour Shop',                      30.3498,  -97.7322, 'ChIJPflourShopBakery_ATX079', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Tous les Jours',                   30.3528,  -97.7411, 'ChIJTousLesJours_____ATX080', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Upper Crust Bakery',               30.3148,  -97.7323, 'ChIJUpperCrustBakery_ATX081', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('ThoroughBread',                    30.2618,  -97.7731, 'ChIJThoroughBread____ATX082', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Mercado Sin Nombre',               30.2758,  -97.7182, 'ChIJMercadoSinNombre_ATX083', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Teal House Coffee & Bakery',       30.2958,  -97.6911, 'ChIJTealHouseBakery__ATX084', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Swedish Hill Bakery',              30.2511,  -97.7572, 'ChIJSwedishHillBakery ATX085', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Elizabeth Street Cafe',            30.2519,  -97.7571, 'ChIJElizabethStCafe__ATX086', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Walton''s Fancy & Staple',         30.2718,  -97.7598, 'ChIJWaltonsFancyStapl ATX087', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('The Salty Donut',                  30.2441,  -97.7521, 'ChIJSaltyDonutATX____ATX088', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Texas French Bread',               30.2898,  -97.7498, 'ChIJTexasFrenchBread_ATX089', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id')),
  ('Sweetish Hill Bakery',             30.2724,  -97.7698, 'ChIJSweetishHill_____ATX090', 'BAKERY', (SELECT id FROM users WHERE google_id = 'seed_admin_google_id'));

COMMIT;
