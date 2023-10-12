
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
    LEN
}

enum Rarity {
    Common,
    Uncommon,
    Rare,
    Epic,
    Legendary,
    Mythical,
    Ascended,
    Ultimate
}