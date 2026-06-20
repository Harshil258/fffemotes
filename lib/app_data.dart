import 'package:flutter/material.dart';

// ── Enums ──────────────────────────────────────────────────────────────────
enum EmoteRarity {
  common('COMMON', Color(0xFF90A4AE), 'C'),
  rare('RARE', Color(0xFF448AFF), 'R'),
  epic('EPIC', Color(0xFF7C4DFF), 'E'),
  legendary('LEGENDARY', Color(0xFFFFD740), 'L'),
  mythic('MYTHIC', Color(0xFFFF4081), 'M');

  final String label;
  final Color color;
  final String code;
  const EmoteRarity(this.label, this.color, this.code);
}

enum EmoteMoveType {
  dance('DANCE MOVE', Icons.music_note_rounded),
  taunt('TAUNT', Icons.front_hand_rounded),
  gesture('GESTURE', Icons.waving_hand_rounded),
  celebration('CELEBRATION', Icons.celebration_rounded),
  pose('BATTLE POSE', Icons.sports_martial_arts_rounded),
  freestyle('FREESTYLE', Icons.self_improvement_rounded);

  final String label;
  final IconData icon;
  const EmoteMoveType(this.label, this.icon);
}

enum ToolRarity {
  common('COMMON', Color(0xFF90A4AE)),
  rare('RARE', Color(0xFF448AFF)),
  epic('EPIC', Color(0xFF7C4DFF)),
  legendary('LEGENDARY', Color(0xFFFFD740)),
  mythic('MYTHIC', Color(0xFFFF4081));

  final String label;
  final Color color;
  const ToolRarity(this.label, this.color);
}

// ── Emote Model ────────────────────────────────────────────────────────────
class EmoteItem {
  final String id;
  final String name;
  final String description;
  final EmoteRarity rarity;
  final EmoteMoveType moveType;
  final IconData icon;
  final String imagePath;
  final int rarityPercent;
  final String demand;
  final List<String> choreography;

  const EmoteItem({
    required this.id,
    required this.name,
    required this.description,
    required this.rarity,
    required this.moveType,
    required this.icon,
    required this.imagePath,
    this.rarityPercent = 75,
    this.demand = 'HIGH',
    this.choreography = const ['Initiate Stance', 'Execute Sequence', 'Finish Move'],
  });
}

// ── Category Model ─────────────────────────────────────────────────────────
class EmoteCategory {
  final String id;
  final String name;
  final String subtitle;
  final IconData icon;
  final List<EmoteItem> emotes;

  const EmoteCategory({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.emotes,
  });
}

// ── Tool Model ─────────────────────────────────────────────────────────────
class ToolItem {
  final String id;
  final String name;
  final String description;
  final ToolRarity rarity;
  final String imagePath;
  final int damage;
  final int rateOfFire;
  final int range;
  final int accuracy;
  final List<String> evoLevels;

  const ToolItem({
    required this.id,
    required this.name,
    required this.description,
    required this.rarity,
    required this.imagePath,
    required this.damage,
    required this.rateOfFire,
    required this.range,
    required this.accuracy,
    required this.evoLevels,
  });
}

class ToolCategory {
  final String id;
  final String name;
  final String subtitle;
  final IconData icon;
  final List<ToolItem> tools;

  const ToolCategory({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.tools,
  });
}

// ── Tier Model ─────────────────────────────────────────────────────────────
class TierItem {
  final String name;
  final String badge;
  final String description;
  final Color color;
  final Color bgColor;

  const TierItem({
    required this.name,
    required this.badge,
    required this.description,
    required this.color,
    required this.bgColor,
  });
}

// ── Level Range Model ──────────────────────────────────────────────────────
class LevelRange {
  final String label;
  final String description;
  final Color color;
  final Color iconBg;

  const LevelRange({
    required this.label,
    required this.description,
    required this.color,
    required this.iconBg,
  });
}

// ── League Model ───────────────────────────────────────────────────────────
class LeagueItem {
  final String name;
  final IconData icon;
  final Color color;
  final Color bgStart;
  final Color bgEnd;

  const LeagueItem({
    required this.name,
    required this.icon,
    required this.color,
    required this.bgStart,
    required this.bgEnd,
  });
}

// ══════════════════════════════════════════════════════════════════════════
//  STATIC DATA
// ══════════════════════════════════════════════════════════════════════════

class AppData {
  AppData._();

  // ── Categories with Emotes ─────────────────────────────────────────────
  static const List<EmoteCategory> categories = [
    EmoteCategory(
      id: 'victory_dances',
      name: 'VICTORY DANCES',
      subtitle: 'Celebrate your wins in style',
      icon: Icons.emoji_events_rounded,
      emotes: [
        EmoteItem(
          id: 'vd_01', name: 'BOOYAH SHAKE', icon: Icons.music_note_rounded,
          imagePath: 'assets/images/ff_char_1_1.webp',
          description: 'The iconic victory celebration. Show your opponents who\'s the champion with this legendary shake move that has become a symbol of dominance in the arena.',
          rarity: EmoteRarity.legendary, moveType: EmoteMoveType.dance, rarityPercent: 99,
          choreography: ['Power stance initiation', 'Hip rotation sequence', 'Arms raised triumph'],
        ),
        EmoteItem(
          id: 'vd_02', name: 'CHAMPION WALK', icon: Icons.directions_walk_rounded,
          imagePath: 'assets/images/ff_char_2_1.webp',
          description: 'A confident strut that tells everyone you own the battlefield. Walk like a champion, feel like a champion.',
          rarity: EmoteRarity.epic, moveType: EmoteMoveType.pose, rarityPercent: 85,
          choreography: ['Chest forward stance', 'Slow confident stride', 'Victory point gesture'],
        ),
        EmoteItem(
          id: 'vd_03', name: 'DISCO FEVER', icon: Icons.nightlife_rounded,
          imagePath: 'assets/images/ff_char_3_1.webp',
          description: 'Hit the dance floor with retro disco moves. Spinning lights not included, but the energy is off the charts.',
          rarity: EmoteRarity.rare, moveType: EmoteMoveType.dance, rarityPercent: 65,
          choreography: ['Point to the sky', 'Hip groove sequence', 'Spin and freeze'],
        ),
        EmoteItem(
          id: 'vd_04', name: 'BREAKDANCE BURST', icon: Icons.sports_gymnastics_rounded,
          imagePath: 'assets/images/ff_char_4_1.webp',
          description: 'Drop to the floor and spin like a top. This acrobatic emote is guaranteed to impress.',
          rarity: EmoteRarity.mythic, moveType: EmoteMoveType.freestyle, rarityPercent: 98,
          choreography: ['Drop to floor', 'Windmill spin', 'Freeze pose finale'],
        ),
        EmoteItem(
          id: 'vd_05', name: 'SALUTE SNAP', icon: Icons.military_tech_rounded,
          imagePath: 'assets/images/ff_char_5_1.webp',
          description: 'A crisp military salute followed by a finger snap. Respect earned, respect given.',
          rarity: EmoteRarity.common, moveType: EmoteMoveType.gesture, rarityPercent: 30,
          choreography: ['Stand at attention', 'Sharp salute', 'Snap and release'],
        ),
        EmoteItem(
          id: 'vd_06', name: 'GOLD RUSH', icon: Icons.star_rounded,
          imagePath: 'assets/images/ff_char_6_1.webp',
          description: 'Shower yourself in virtual gold. The most extravagant victory dance in the vault.',
          rarity: EmoteRarity.legendary, moveType: EmoteMoveType.celebration, rarityPercent: 95,
          choreography: ['Arms spread wide', 'Gold rain gesture', 'Crown yourself'],
        ),
      ],
    ),
    EmoteCategory(
      id: 'taunt_moves',
      name: 'TAUNT MOVES',
      subtitle: 'Get under their skin',
      icon: Icons.front_hand_rounded,
      emotes: [
        EmoteItem(
          id: 'tm_01', name: 'LOL LAUGH', icon: Icons.sentiment_very_satisfied_rounded,
          imagePath: 'assets/images/ff_char_7_1.webp',
          description: 'An exaggerated laugh that echoes across the battlefield. Use sparingly for maximum psychological effect.',
          rarity: EmoteRarity.epic, moveType: EmoteMoveType.taunt, rarityPercent: 82,
          choreography: ['Bend forward slightly', 'Exaggerated laugh motion', 'Point at opponent'],
        ),
        EmoteItem(
          id: 'tm_02', name: 'COME AT ME', icon: Icons.pan_tool_alt_rounded,
          imagePath: 'assets/images/ff_char_8_1.webp',
          description: 'The universal "bring it on" gesture. Wave them in, dare them to make a move.',
          rarity: EmoteRarity.rare, moveType: EmoteMoveType.taunt, rarityPercent: 60,
          choreography: ['Wide stance', 'Beckoning hand motion', 'Confident nod'],
        ),
        EmoteItem(
          id: 'tm_03', name: 'YAWN STRETCH', icon: Icons.hotel_rounded,
          imagePath: 'assets/images/ff_char_9_1.webp',
          description: 'Nothing says "you bore me" quite like a dramatic yawn and stretch mid-battle.',
          rarity: EmoteRarity.common, moveType: EmoteMoveType.taunt, rarityPercent: 40,
          choreography: ['Big yawn open', 'Full body stretch', 'Check nails casually'],
        ),
        EmoteItem(
          id: 'tm_04', name: 'CROWN FLIP', icon: Icons.auto_awesome_rounded,
          imagePath: 'assets/images/ff_char_10_1.webp',
          description: 'Flip an imaginary crown and catch it on your head. Royalty doesn\'t need to try hard.',
          rarity: EmoteRarity.legendary, moveType: EmoteMoveType.taunt, rarityPercent: 92,
          choreography: ['Remove crown', 'Toss in the air', 'Catch and place back'],
        ),
        EmoteItem(
          id: 'tm_05', name: 'SHADOW BOX', icon: Icons.sports_mma_rounded,
          imagePath: 'assets/images/ff_char_11_1.webp',
          description: 'Quick shadow boxing combo to show you mean business. Fast fists, faster wins.',
          rarity: EmoteRarity.epic, moveType: EmoteMoveType.pose, rarityPercent: 78,
          choreography: ['Fighting stance', 'Quick combo punches', 'Guard up finish'],
        ),
        EmoteItem(
          id: 'tm_06', name: 'DUST OFF', icon: Icons.cleaning_services_rounded,
          imagePath: 'assets/images/ff_char_12_1.webp',
          description: 'Casually dust off your shoulders like defeating them was nothing. Pure disrespect.',
          rarity: EmoteRarity.rare, moveType: EmoteMoveType.gesture, rarityPercent: 55,
          choreography: ['Look at shoulder', 'Brush both shoulders', 'Walk away motion'],
        ),
      ],
    ),
    EmoteCategory(
      id: 'legendary_emotes',
      name: 'LEGENDARY EMOTES',
      subtitle: 'Ultra-rare collector items',
      icon: Icons.diamond_rounded,
      emotes: [
        EmoteItem(
          id: 'le_01', name: 'DRAGON RISE', icon: Icons.whatshot_rounded,
          imagePath: 'assets/images/ff_char_1_2.webp',
          description: 'Channel the power of the dragon with this mythic-tier emote. Fire effects and dramatic poses make this the crown jewel.',
          rarity: EmoteRarity.mythic, moveType: EmoteMoveType.celebration, rarityPercent: 99,
          choreography: ['Crouch low', 'Rising dragon motion', 'Fire breath pose'],
        ),
        EmoteItem(
          id: 'le_02', name: 'THUNDER CLAP', icon: Icons.bolt_rounded,
          imagePath: 'assets/images/ff_char_2_2.webp',
          description: 'Bring the thunder with a massive double-hand clap that shakes the screen.',
          rarity: EmoteRarity.legendary, moveType: EmoteMoveType.gesture, rarityPercent: 94,
          choreography: ['Arms wide apart', 'Dramatic clap', 'Shockwave pose'],
        ),
        EmoteItem(
          id: 'le_03', name: 'PHOENIX WAVE', icon: Icons.local_fire_department_rounded,
          imagePath: 'assets/images/ff_char_3_2.webp',
          description: 'Rise from the ashes with fiery wing motions. A rebirth celebration for the elite.',
          rarity: EmoteRarity.mythic, moveType: EmoteMoveType.freestyle, rarityPercent: 97,
          choreography: ['Kneel position', 'Wings unfurl motion', 'Soar upward'],
        ),
        EmoteItem(
          id: 'le_04', name: 'NINJA VANISH', icon: Icons.visibility_off_rounded,
          imagePath: 'assets/images/ff_char_4_2.webp',
          description: 'The classic ninja disappearance. Smoke bomb hands, then gone. Mysterious and cool.',
          rarity: EmoteRarity.legendary, moveType: EmoteMoveType.gesture, rarityPercent: 90,
          choreography: ['Hands together', 'Smoke bomb gesture', 'Vanish crouch'],
        ),
        EmoteItem(
          id: 'le_05', name: 'ASTRAL DANCE', icon: Icons.auto_awesome_rounded,
          imagePath: 'assets/images/ff_char_5_2.webp',
          description: 'A cosmic-themed dance with constellation patterns. Dance among the stars.',
          rarity: EmoteRarity.mythic, moveType: EmoteMoveType.dance, rarityPercent: 99,
          choreography: ['Arms trace stars', 'Orbital spin', 'Constellation freeze'],
        ),
        EmoteItem(
          id: 'le_06', name: 'SAMURAI SLASH', icon: Icons.content_cut_rounded,
          imagePath: 'assets/images/ff_char_6_2.webp',
          description: 'Draw an invisible katana and perform a clean three-strike combo. Bushido code honored.',
          rarity: EmoteRarity.legendary, moveType: EmoteMoveType.pose, rarityPercent: 88,
          choreography: ['Draw katana', 'Three slash combo', 'Sheathe and bow'],
        ),
      ],
    ),
    EmoteCategory(
      id: 'battle_poses',
      name: 'BATTLE POSES',
      subtitle: 'Strike your power stance',
      icon: Icons.sports_martial_arts_rounded,
      emotes: [
        EmoteItem(
          id: 'bp_01', name: 'IRON GUARD', icon: Icons.shield_rounded,
          imagePath: 'assets/images/ff_char_7_2.webp',
          description: 'An impenetrable defensive stance that radiates pure strength and resilience.',
          rarity: EmoteRarity.epic, moveType: EmoteMoveType.pose, rarityPercent: 80,
          choreography: ['Feet planted wide', 'Arms crossed guard', 'Intense stare'],
        ),
        EmoteItem(
          id: 'bp_02', name: 'SNIPER READY', icon: Icons.gps_fixed_rounded,
          imagePath: 'assets/images/ff_char_8_2.webp',
          description: 'Get into position, scope in, and show them you never miss. The marksman\'s calling card.',
          rarity: EmoteRarity.rare, moveType: EmoteMoveType.pose, rarityPercent: 62,
          choreography: ['Drop to one knee', 'Scope aim motion', 'Trigger finger ready'],
        ),
        EmoteItem(
          id: 'bp_03', name: 'WAR CRY', icon: Icons.record_voice_over_rounded,
          imagePath: 'assets/images/ff_char_9_2.webp',
          description: 'Beat your chest and let out a primal war cry. Intimidation at its finest.',
          rarity: EmoteRarity.legendary, moveType: EmoteMoveType.taunt, rarityPercent: 91,
          choreography: ['Chest beat', 'Head thrown back', 'Fists raised roar'],
        ),
        EmoteItem(
          id: 'bp_04', name: 'TACTICAL ROLL', icon: Icons.sports_gymnastics_rounded,
          imagePath: 'assets/images/ff_char_10_2.webp',
          description: 'A swift combat roll that transitions into a ready stance. Agility personified.',
          rarity: EmoteRarity.epic, moveType: EmoteMoveType.freestyle, rarityPercent: 76,
          choreography: ['Forward lean', 'Combat roll', 'Spring to ready'],
        ),
        EmoteItem(
          id: 'bp_05', name: 'MUSCLE FLEX', icon: Icons.fitness_center_rounded,
          imagePath: 'assets/images/ff_char_11_2.webp',
          description: 'Show off those gains with a basic bodybuilder pose sequence.',
          rarity: EmoteRarity.common, moveType: EmoteMoveType.pose, rarityPercent: 35,
          choreography: ['Side chest pose', 'Double bicep', 'Most muscular'],
        ),
        EmoteItem(
          id: 'bp_06', name: 'KNIFE FLIP', icon: Icons.architecture_rounded,
          imagePath: 'assets/images/ff_char_12_2.webp',
          description: 'A fancy knife flip trick that ends with a combat-ready grip. Style meets lethality.',
          rarity: EmoteRarity.rare, moveType: EmoteMoveType.gesture, rarityPercent: 58,
          choreography: ['Draw knife', 'Aerial flip', 'Catch and stance'],
        ),
      ],
    ),
    EmoteCategory(
      id: 'party_vibes',
      name: 'PARTY VIBES',
      subtitle: 'Turn the lobby into a club',
      icon: Icons.celebration_rounded,
      emotes: [
        EmoteItem(
          id: 'pv_01', name: 'DJ DROP', icon: Icons.headphones_rounded,
          imagePath: 'assets/images/ff_char_1_3.webp',
          description: 'Put on invisible headphones and drop the beat. The lobby is now your dance floor.',
          rarity: EmoteRarity.epic, moveType: EmoteMoveType.dance, rarityPercent: 83,
          choreography: ['Headphones on', 'Turntable scratch', 'Bass drop bounce'],
        ),
        EmoteItem(
          id: 'pv_02', name: 'CONFETTI BLAST', icon: Icons.celebration_rounded,
          imagePath: 'assets/images/ff_char_2_3.webp',
          description: 'Pop confetti from your hands and celebrate like it\'s New Year\'s Eve.',
          rarity: EmoteRarity.rare, moveType: EmoteMoveType.celebration, rarityPercent: 55,
          choreography: ['Hands together', 'Explosive pop', 'Arms in the air'],
        ),
        EmoteItem(
          id: 'pv_03', name: 'ROBOT GLITCH', icon: Icons.smart_toy_rounded,
          imagePath: 'assets/images/ff_char_3_3.webp',
          description: 'Malfunction in the most entertaining way. Robotic jerks and digital glitches.',
          rarity: EmoteRarity.legendary, moveType: EmoteMoveType.dance, rarityPercent: 93,
          choreography: ['Stiff robot stance', 'Glitch twitch', 'System reboot pose'],
        ),
        EmoteItem(
          id: 'pv_04', name: 'MOONWALK PRO', icon: Icons.directions_walk_rounded,
          imagePath: 'assets/images/ff_char_4_3.webp',
          description: 'The smoothest moonwalk you\'ve ever seen. Glide backwards with zero effort.',
          rarity: EmoteRarity.mythic, moveType: EmoteMoveType.dance, rarityPercent: 97,
          choreography: ['Smooth start', 'Backward glide', 'Spin finish'],
        ),
        EmoteItem(
          id: 'pv_05', name: 'AIR GUITAR', icon: Icons.music_note_rounded,
          imagePath: 'assets/images/ff_char_5_3.webp',
          description: 'Shred an invisible guitar with epic rock star energy. Solo mode activated.',
          rarity: EmoteRarity.rare, moveType: EmoteMoveType.freestyle, rarityPercent: 50,
          choreography: ['Guitar grab', 'Power riff', 'Windmill strum'],
        ),
        EmoteItem(
          id: 'pv_06', name: 'FIRE SPINNER', icon: Icons.local_fire_department_rounded,
          imagePath: 'assets/images/ff_char_6_3.webp',
          description: 'Spin with trails of fire around you. The most hypnotic party trick in the game.',
          rarity: EmoteRarity.legendary, moveType: EmoteMoveType.dance, rarityPercent: 90,
          choreography: ['Arms out', 'Rapid spin', 'Fire trail finish'],
        ),
      ],
    ),
    EmoteCategory(
      id: 'signature_moves',
      name: 'SIGNATURE MOVES',
      subtitle: 'Make your mark',
      icon: Icons.auto_fix_high_rounded,
      emotes: [
        EmoteItem(
          id: 'sm_01', name: 'THRONE SIT', icon: Icons.chair_rounded,
          imagePath: 'assets/images/ff_char_7_3.webp',
          description: 'Summon an invisible throne and sit down like royalty. The ultimate power move.',
          rarity: EmoteRarity.mythic, moveType: EmoteMoveType.gesture, rarityPercent: 98,
          choreography: ['Snap fingers', 'Throne conjure', 'Royal sit down'],
        ),
        EmoteItem(
          id: 'sm_02', name: 'DEATH STARE', icon: Icons.remove_red_eye_rounded,
          imagePath: 'assets/images/ff_char_8_3.webp',
          description: 'Lock eyes with your enemy in the most intense stare-down. No words needed.',
          rarity: EmoteRarity.epic, moveType: EmoteMoveType.taunt, rarityPercent: 79,
          choreography: ['Slow head turn', 'Eyes lock', 'Menacing grin'],
        ),
        EmoteItem(
          id: 'sm_03', name: 'MAGIC TRICK', icon: Icons.auto_awesome_rounded,
          imagePath: 'assets/images/ff_char_9_3.webp',
          description: 'Pull off a sleight of hand that makes objects appear and disappear. Magic!',
          rarity: EmoteRarity.legendary, moveType: EmoteMoveType.gesture, rarityPercent: 88,
          choreography: ['Show empty hands', 'Magic wave', 'Reveal surprise'],
        ),
        EmoteItem(
          id: 'sm_04', name: 'BACKFLIP', icon: Icons.sports_gymnastics_rounded,
          imagePath: 'assets/images/ff_char_10_3.webp',
          description: 'A clean backflip that sticks the landing perfectly. Athletic excellence.',
          rarity: EmoteRarity.epic, moveType: EmoteMoveType.freestyle, rarityPercent: 72,
          choreography: ['Quick crouch', 'Backflip execute', 'Stick the landing'],
        ),
        EmoteItem(
          id: 'sm_05', name: 'HEART HANDS', icon: Icons.favorite_rounded,
          imagePath: 'assets/images/ff_char_11_3.webp',
          description: 'Make a heart shape with your hands. Spread love, not bullets. Well, maybe both.',
          rarity: EmoteRarity.common, moveType: EmoteMoveType.gesture, rarityPercent: 25,
          choreography: ['Hands up', 'Form heart shape', 'Heart pulse motion'],
        ),
        EmoteItem(
          id: 'sm_06', name: 'GANGNAM STYLE', icon: Icons.nightlife_rounded,
          imagePath: 'assets/images/ff_char_12_3.webp',
          description: 'The legendary K-pop dance that took the world by storm. Oppa!',
          rarity: EmoteRarity.legendary, moveType: EmoteMoveType.dance, rarityPercent: 95,
          choreography: ['Horse stance', 'Lasso arm swing', 'Signature bounce'],
        ),
      ],
    ),
  ];

  // ── Categories with Tools ─────────────────────────────────────────────
  static const List<ToolCategory> toolCategories = [
    ToolCategory(
      id: 'evo_guns',
      name: 'EVO GUNS ARSENAL',
      subtitle: 'Legendary weapon upgrade skins',
      icon: Icons.local_fire_department_rounded,
      tools: [
        ToolItem(
          id: 't_eg_01', name: 'AK47 - BLUE FLAME DRACO',
          description: 'The absolute pinnacle of assault rifle customization. Features realistic dragon animation, custom kill feed broadcasts, and destructive firepower that increases as it level up.',
          rarity: ToolRarity.mythic, imagePath: 'assets/images/ff_weapon_1.webp',
          damage: 95, rateOfFire: 90, range: 85, accuracy: 78,
          evoLevels: [
            'Level 1: Basic design and dragon skin texture.',
            'Level 2: Unlocks exclusive Draco kill announcement.',
            'Level 3: Wing shape emerges on the weapon body.',
            'Level 4: Fire-blast bullet hit effect unlocked.',
            'Level 5: Firing flame muzzle flash effect active.',
            'Level 6: Full dragon wings animation and high damage multiplier.',
            'Level 7: Unlocks the unique Draco Roar emote and final form.',
          ],
        ),
        ToolItem(
          id: 't_eg_02', name: 'M1014 - GREEN FLAME DRACO',
          description: 'Devastating close-range shotgun infected with radioactive green fire. Crushes enemy armor with ease and emits a toxicity trail.',
          rarity: ToolRarity.legendary, imagePath: 'assets/images/ff_weapon_2.webp',
          damage: 98, rateOfFire: 70, range: 45, accuracy: 50,
          evoLevels: [
            'Level 1: Basic green scale finish.',
            'Level 2: Radioactive kill feed broadcast.',
            'Level 3: Spikes develop on the shotgun barrel.',
            'Level 4: Green splash bullet impact effect.',
            'Level 5: Toxic green muzzle gas.',
            'Level 6: Double stats boost and skeletal design.',
            'Level 7: Exclusive Toxic Slash animation emote.',
          ],
        ),
        ToolItem(
          id: 't_eg_03', name: 'MP40 - PREDATORY COBRA',
          description: 'Lightning-fast SMG wrapped in the coils of a crimson cobra. Dominates close-quarters combat with high rate of fire and bonus venom damage.',
          rarity: ToolRarity.mythic, imagePath: 'assets/images/ff_weapon_3.webp',
          damage: 88, rateOfFire: 99, range: 60, accuracy: 70,
          evoLevels: [
            'Level 1: Basic red snake skin grip.',
            'Level 2: Cobra emblem kill banner.',
            'Level 3: Snake head sight indicator.',
            'Level 4: Red lightning hit sparks.',
            'Level 5: Venomous smoke release on reload.',
            'Level 6: Full serpent form animation.',
            'Level 7: Cobra Strike lobby emote unlocked.',
          ],
        ),
        ToolItem(
          id: 't_eg_04', name: 'SCAR - MEGALODON ALPHA',
          description: 'A futuristic ocean-themed assault rifle forged in the image of a prehistoric shark. Shoots crimson lasers that tear through walls.',
          rarity: ToolRarity.legendary, imagePath: 'assets/images/ff_weapon_4.webp',
          damage: 92, rateOfFire: 88, range: 80, accuracy: 75,
          evoLevels: [
            'Level 1: Metallic shark plate structure.',
            'Level 2: Crimson ocean kill announcer.',
            'Level 3: Fin stabilizer attachments.',
            'Level 4: Red splash shield hit effects.',
            'Level 5: Bubbling blood muzzle fire.',
            'Level 6: Cybernetic shark head animation.',
            'Level 7: Shark Frenzy lobby emote.',
          ],
        ),
        ToolItem(
          id: 't_eg_05', name: 'XM8 - DESTINY GUARDIAN',
          description: 'Celestial weapon from another dimension, guided by cosmic light. High accuracy and automatic targets-tracking capability.',
          rarity: ToolRarity.epic, imagePath: 'assets/images/ff_weapon_5.webp',
          damage: 85, rateOfFire: 82, range: 75, accuracy: 80,
          evoLevels: [
            'Level 1: Crystal-tinted energy core.',
            'Level 2: Cosmic light kill announcement.',
            'Level 3: Floating runic wing tips.',
            'Level 4: Starlight impact bursts.',
            'Level 5: Nebula warp reload effect.',
            'Level 6: Full angelic armor casing.',
            'Level 7: Destiny Portal emote.',
          ],
        ),
        ToolItem(
          id: 't_eg_06', name: 'M1887 - STERLING CONQUEROR',
          description: 'Double-barrel blast shotgun styled in shiny platinum and golden filigree. Extreme lethality, designed for victory.',
          rarity: ToolRarity.mythic, imagePath: 'assets/images/ff_weapon_6.webp',
          damage: 99, rateOfFire: 65, range: 48, accuracy: 52,
          evoLevels: [
            'Level 1: Silver barrel framing.',
            'Level 2: Golden crown kill announcement.',
            'Level 3: Golden engravings detail.',
            'Level 4: Sparkler hit particle effects.',
            'Level 5: Royal golden trail flash.',
            'Level 6: Full armor casing and golden wings.',
            'Level 7: Sovereign Pose emote.',
          ],
        ),
      ],
    ),
    ToolCategory(
      id: 'tactical_companions',
      name: 'TACTICAL COMPANIONS',
      subtitle: 'Premium pets with elite combat abilities',
      icon: Icons.pets_rounded,
      tools: [
        ToolItem(
          id: 't_tc_01', name: 'KACTUS COMPANION',
          description: 'A small, hardy desert sentinel. Perfect for defensive and stealth tactics, allowing players to recover resources when keeping still.',
          rarity: ToolRarity.rare, imagePath: 'assets/images/ff_pet_1.webp',
          damage: 10, rateOfFire: 0, range: 15, accuracy: 90,
          evoLevels: [
            'Level 1: Basic cacti skin. Ability: Recovers 5 EP/sec when standing still for 3s.',
            'Level 2: Unlocks "Waving Spike" action.',
            'Level 3: Shiny flower bud accessory.',
            'Level 4: Ability: Recovers 7 EP/sec when standing still for 2.5s.',
            'Level 5: Unlocks "Spike Blast" visual aura.',
            'Level 6: Metallic cyborg armor skin.',
            'Level 7: Ability: Recovers 10 EP/sec when standing still for 2s.',
          ],
        ),
        ToolItem(
          id: 't_tc_02', name: 'FANG THE SENTINEL',
          description: 'A robotic cyber-wolf companion that detects vulnerabilities and provides shield support to its master in high-stakes firefights.',
          rarity: ToolRarity.epic, imagePath: 'assets/images/ff_pet_2.webp',
          damage: 25, rateOfFire: 0, range: 20, accuracy: 85,
          evoLevels: [
            'Level 1: Cybernetic chassis. Ability: Grants 10 EP when team member is down.',
            'Level 2: Unlocks "Wolf Howl" action.',
            'Level 3: Blue neon core exhaust.',
            'Level 4: Ability: Grants 20 EP/HP when team member is down.',
            'Level 5: Unlocks neon running trails.',
            'Level 6: Shadow Wolf titanium skin.',
            'Level 7: Ability: Grants 30 EP and 10 HP to master immediately when team member is down.',
          ],
        ),
        ToolItem(
          id: 't_tc_03', name: 'YETI BEAST',
          description: 'A mini-glacier monster that absorbs shockwaves and protects the user from grenade attacks and explosive payloads.',
          rarity: ToolRarity.rare, imagePath: 'assets/images/ff_pet_3.webp',
          damage: 15, rateOfFire: 0, range: 10, accuracy: 75,
          evoLevels: [
            'Level 1: Wooly white coat. Ability: Reduces 15% explosive damage (CD 150s).',
            'Level 2: Unlocks "Snowball Roll" action.',
            'Level 3: Polar goggles accessory.',
            'Level 4: Ability: Reduces 20% explosive damage (CD 120s).',
            'Level 5: Frost storm aura around the pet.',
            'Level 6: Ice Warrior crystal armor.',
            'Level 7: Ability: Reduces 30% explosive damage (CD 90s).',
          ],
        ),
        ToolItem(
          id: 't_tc_04', name: 'AGENT HOP',
          description: 'A cyber-enhanced rabbit agent equipped with tactical scanners. Excellent for fast zone rotations and late-game survival.',
          rarity: ToolRarity.epic, imagePath: 'assets/images/ff_pet_4.webp',
          damage: 20, rateOfFire: 0, range: 30, accuracy: 95,
          evoLevels: [
            'Level 1: Leather vest and eye-patch. Ability: Grants 30 EP when Safe Zone shrinks.',
            'Level 2: Unlocks "Salute" action.',
            'Level 3: Tactical backpack skin.',
            'Level 4: Ability: Grants 40 EP when Safe Zone shrinks.',
            'Level 5: Holographic target scanner overlay.',
            'Level 6: Stealth agent carbon-fiber outfit.',
            'Level 7: Ability: Grants 50 EP when Safe Zone shrinks.',
          ],
        ),
        ToolItem(
          id: 't_tc_05', name: 'ZASIL THE PROTECTOR',
          description: 'An aquatic axolotl companion that doubles medical consumables efficiency. Helps you patch up faster in cover.',
          rarity: ToolRarity.rare, imagePath: 'assets/images/ff_pet_5.webp',
          damage: 5, rateOfFire: 0, range: 5, accuracy: 80,
          evoLevels: [
            'Level 1: Pink water bubbles. Ability: 33% chance to get an extra Medkit on use.',
            'Level 2: Unlocks "Float Dance" action.',
            'Level 3: Aqua goggles.',
            'Level 4: Ability: 40% chance to get an extra Medkit/Inhaler on use.',
            'Level 5: Glow bioluminescence aura.',
            'Level 6: Deepsea neon predator skin.',
            'Level 7: Ability: 50% chance to get an extra Medkit/Inhaler/Repair Kit on use.',
          ],
        ),
        ToolItem(
          id: 't_tc_06', name: 'OTTERO THE DJ',
          description: 'A music-loving otter that heals your EP while you heal your HP. Perfect companion for aggressive run-and-gun players.',
          rarity: ToolRarity.legendary, imagePath: 'assets/images/ff_pet_6.webp',
          damage: 12, rateOfFire: 0, range: 12, accuracy: 88,
          evoLevels: [
            'Level 1: DJ hoodie and headphones. Ability: Recover EP equivalent to 35% of HP healed.',
            'Level 2: Unlocks "DJ Scratch" dance action.',
            'Level 3: Gold chain necklace accessory.',
            'Level 4: Ability: Recover EP equivalent to 50% of HP healed.',
            'Level 5: Rhythm soundwave glow.',
            'Level 6: Cyber DJ gold helmet skin.',
            'Level 7: Ability: Recover EP equivalent to 65% of HP healed.',
          ],
        ),
      ],
    ),
  ];

  // ── Tiers ────────────────────────────────────────────────────────────────
  static const List<TierItem> tiers = [
    TierItem(
      name: 'NO-PREFERENCE',
      badge: 'BRONZE',
      description: 'Execute No-Preference synchronization protocol',
      color: Color(0xFFCD7F32),
      bgColor: Color(0xFF2A1F0A),
    ),
    TierItem(
      name: 'BR-RANKED',
      badge: 'SILVER',
      description: 'Execute BR-Ranked synchronization protocol',
      color: Color(0xFFC0C0C0),
      bgColor: Color(0xFF1A1A1A),
    ),
    TierItem(
      name: 'CS-RANKED',
      badge: 'GOLD',
      description: 'Execute CS-Ranked synchronization protocol',
      color: Color(0xFFFFD740),
      bgColor: Color(0xFF2A250A),
    ),
    TierItem(
      name: 'CASUAL MODES',
      badge: 'PLATINUM',
      description: 'Execute Casual Modes synchronization protocol',
      color: Color(0xFF00BCD4),
      bgColor: Color(0xFF0A2A2A),
    ),
  ];

  // ── Level Ranges ─────────────────────────────────────────────────────────
  static const List<LevelRange> levelRanges = [
    LevelRange(
      label: 'LEVEL 0-25',
      description: 'Syncing maturity parameters for Level 0-25',
      color: Color(0xFF00FFA3),
      iconBg: Color(0xFF0A3B2A),
    ),
    LevelRange(
      label: 'LEVEL 26-40',
      description: 'Syncing maturity parameters for Level 26-40',
      color: Color(0xFF00BCD4),
      iconBg: Color(0xFF0A2A3B),
    ),
    LevelRange(
      label: 'LEVEL 41-60',
      description: 'Syncing maturity parameters for Level 41-60',
      color: Color(0xFFFF4081),
      iconBg: Color(0xFF3B0A2A),
    ),
    LevelRange(
      label: 'LEVEL 61-90',
      description: 'Syncing maturity parameters for Level 61-90',
      color: Color(0xFFFFD740),
      iconBg: Color(0xFF3B350A),
    ),
    LevelRange(
      label: 'LEVEL 90+',
      description: 'Syncing maturity parameters for Level 90+',
      color: Color(0xFF7C4DFF),
      iconBg: Color(0xFF1F0A3B),
    ),
  ];

  // ── Leagues ──────────────────────────────────────────────────────────────
  static const List<LeagueItem> leagues = [
    LeagueItem(name: 'BRONZE', icon: Icons.shield_rounded, color: Color(0xFFCD7F32), bgStart: Color(0xFF3B2A0A), bgEnd: Color(0xFF261F0A)),
    LeagueItem(name: 'SILVER', icon: Icons.shield_rounded, color: Color(0xFFC0C0C0), bgStart: Color(0xFF2A2A2A), bgEnd: Color(0xFF1A1A1A)),
    LeagueItem(name: 'GOLD', icon: Icons.shield_rounded, color: Color(0xFFFFD740), bgStart: Color(0xFF3B350A), bgEnd: Color(0xFF26220A)),
    LeagueItem(name: 'HEROIC', icon: Icons.local_fire_department_rounded, color: Color(0xFF00BCD4), bgStart: Color(0xFF0A2A3B), bgEnd: Color(0xFF0A1F26)),
    LeagueItem(name: 'MASTER', icon: Icons.star_rounded, color: Color(0xFFFF4081), bgStart: Color(0xFF3B0A2A), bgEnd: Color(0xFF260A18)),
    LeagueItem(name: 'GRANDMASTER', icon: Icons.auto_awesome_rounded, color: Color(0xFF7C4DFF), bgStart: Color(0xFF1F0A3B), bgEnd: Color(0xFF150A26)),
  ];
}
