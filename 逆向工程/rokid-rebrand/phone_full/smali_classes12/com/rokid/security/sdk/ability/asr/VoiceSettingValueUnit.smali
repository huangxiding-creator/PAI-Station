.class public final enum Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;
.super Ljava/lang/Enum;
.source "VoiceSettingValueParser.kt"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0012\n\u0002\u0018\u0002\n\u0002\u0010\u0010\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0006\u0008\u0080\u0001\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00000\u0001B\u000f\u0008\u0002\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006j\u0002\u0008\u0007j\u0002\u0008\u0008\u00a8\u0006\t"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;",
        "",
        "wireValue",
        "",
        "(Ljava/lang/String;ILjava/lang/String;)V",
        "getWireValue",
        "()Ljava/lang/String;",
        "LEVEL",
        "PERCENT",
        "sdk-common-ability_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

.field public static final enum LEVEL:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

.field public static final enum PERCENT:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;


# instance fields
.field private final wireValue:Ljava/lang/String;


# direct methods
.method private static final synthetic $values()[Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;
    .locals 2

    sget-object v0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;->LEVEL:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    sget-object v1, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;->PERCENT:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    filled-new-array {v0, v1}, [Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 4

    .line 4
    new-instance v0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    const/4 v1, 0x0

    const-string v2, "level"

    const-string v3, "LEVEL"

    invoke-direct {v0, v3, v1, v2}, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;->LEVEL:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    .line 5
    new-instance v0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    const/4 v1, 0x1

    const-string v2, "percent"

    const-string v3, "PERCENT"

    invoke-direct {v0, v3, v1, v2}, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;->PERCENT:Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;->$values()[Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;->$VALUES:[Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p1, "$enum$name"    # Ljava/lang/String;
    .param p2, "$enum$ordinal"    # I
    .param p3, "wireValue"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 3
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;->wireValue:Ljava/lang/String;

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;
    .locals 1

    const-class v0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    return-object v0
.end method

.method public static values()[Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;
    .locals 1

    sget-object v0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;->$VALUES:[Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    invoke-virtual {v0}, [Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;

    return-object v0
.end method


# virtual methods
.method public final getWireValue()Ljava/lang/String;
    .locals 1

    .line 3
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/VoiceSettingValueUnit;->wireValue:Ljava/lang/String;

    return-object v0
.end method
