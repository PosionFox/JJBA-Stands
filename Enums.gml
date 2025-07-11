
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
    Ordinary = -2,
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
