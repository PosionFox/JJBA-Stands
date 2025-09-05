
enum StandState {
    Idle,
    SkillAOff,
    SkillBOff,
    SkillCOff,
    SkillDOff,
    SkillA,
    SkillB,
    SkillC,
    SkillD,
    LEN
}

enum StandStat {
    Range,
    AttackDamage,
    AttackRange,
    BaseSpd,
    LEN
}

enum StandSkill {
    ActiveOnly,
    Skill,
    SkillAlt,
    Key,
    GpBtn,
    Desc,
    Icon,
    IconAlt,
    MaxHold,
    Hold,
    Damage,
    DamageScale,
    DamagePlayerStat,
    DamageAlt,
    DamageScaleAlt,
    DamagePlayerStatAlt,
    MaxCooldown,
    Cooldown,
    MaxCooldownAlt,
    CooldownAlt,
    MaxExecutionTime,
    ExecutionTime,
    EnergyCost,
    Vars,
    VarsAlt,
    Custom,
    CustomAlt,
    LEN
}

enum Rarity {
    WIP = -3,
    Ordinary,
    Tragic,
    Common,
    Uncommon,
    Rare,
    Epic,
    Legendary,
    Mythical,
    Celestial,
    Ultimate,
    Bizarre,
    Event,
    LEN
}

// forager palette
enum Color {
    Black = 0x000000,
    DarkViolet = 0x1a1117,
    DarkRed = 0x2b2938,
    DarkBlue = 0x342022,
    DarkPink = 0x382537,
    
    Dirt = 0x3d395f,
    Burgundy = 0x3a217a,
    LightDirt = 0x393975,
    DarkPurple = 0x47343b,
    FaintPurple = 0x5c373e,
    MiddlePurple = 0x6a3746,
    
    LightViolet = 0x633f58,
    DarkGreen = 0x456618,
    DimOrange = 0x294dc4,
    Orange = 0x2c75ff,
    FaintRed = 0x4e3c95,
    LightRed = 0x584781,
    
    FaintOrange = 0x404fa9,
    Magenta = 0x7d49a2,
    Red = 0x4a4ae6,
    DirtyOrange1 = 0x4c69c2,
    DirtyOrange2 = 0x5779cf,
    BrightOrange = 0x5c6cff,
    
    DimGreen = 0x5a8539,
    Green = 0x78a944,
    DarkGold = 0x36bfff,
    Gold = 0x2cdcff,
    Skin = 0x5f89da,
    LightOrange = 0x4bacff,
    
    LightSkin = 0x70a0ff,
    LightGreen = 0x4ce083,
    Lime = 0x70ffdc,
    Yellow = 0x75f2ff,
    Purple = 0x822b68,
    MiddleBlue1 = 0x924e49,
    
    MiddleBlue2 = 0x9e5c57,
    BrightPurple = 0xcd4c67,
    BrightRed = 0x855de6,
    GrayBlue = 0xab8478,
    Blue = 0xff9838,
    Teal = 0xc88d5c,
    
    Skin1 = 0x858feb,
    Pink = 0xaa80ff,
    LightPink = 0xb1b1ff,
    Skin2 = 0xabd1ff,
    Skin3 = 0xb0dfff,
    Gray = 0xc2bcb2,
    
    Lavender = 0xffb6d5,
    Aqua = 0xf2ee87,
    PaleSkin = 0xd0d7ff,
    DimWhite = 0xffeae6,
    White = 0xffffff
}


