.class public final enum Lcom/rokid/security/sdk/base/common/aichat/AiContentType;
.super Ljava/lang/Enum;
.source "Choice.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/base/common/aichat/AiContentType$Companion;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/rokid/security/sdk/base/common/aichat/AiContentType;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000c\n\u0002\u0018\u0002\n\u0002\u0010\u0010\n\u0002\u0008\u0006\u0008\u0086\u0001\u0018\u0000 \u00062\u0008\u0012\u0004\u0012\u00020\u00000\u0001:\u0001\u0006B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002j\u0002\u0008\u0003j\u0002\u0008\u0004j\u0002\u0008\u0005\u00a8\u0006\u0007"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/aichat/AiContentType;",
        "",
        "(Ljava/lang/String;I)V",
        "GUIDE",
        "TEXT",
        "AUDIO",
        "Companion",
        "sdk-base-common_release"
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
.field private static final synthetic $VALUES:[Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

.field public static final enum AUDIO:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

.field public static final Companion:Lcom/rokid/security/sdk/base/common/aichat/AiContentType$Companion;

.field public static final enum GUIDE:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

.field public static final enum TEXT:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;


# direct methods
.method private static final synthetic $values()[Lcom/rokid/security/sdk/base/common/aichat/AiContentType;
    .locals 3

    sget-object v0, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->GUIDE:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    sget-object v1, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->TEXT:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    sget-object v2, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->AUDIO:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    filled-new-array {v0, v1, v2}, [Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 3

    .line 51
    new-instance v0, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    const-string v1, "GUIDE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->GUIDE:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    .line 52
    new-instance v0, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    const-string v1, "TEXT"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->TEXT:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    .line 53
    new-instance v0, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    const-string v1, "AUDIO"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->AUDIO:Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    invoke-static {}, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->$values()[Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->$VALUES:[Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    new-instance v0, Lcom/rokid/security/sdk/base/common/aichat/AiContentType$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/sdk/base/common/aichat/AiContentType$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->Companion:Lcom/rokid/security/sdk/base/common/aichat/AiContentType$Companion;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .param p1, "$enum$name"    # Ljava/lang/String;
    .param p2, "$enum$ordinal"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 50
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/aichat/AiContentType;
    .locals 1

    const-class v0, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    return-object v0
.end method

.method public static values()[Lcom/rokid/security/sdk/base/common/aichat/AiContentType;
    .locals 1

    sget-object v0, Lcom/rokid/security/sdk/base/common/aichat/AiContentType;->$VALUES:[Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    invoke-virtual {v0}, [Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/rokid/security/sdk/base/common/aichat/AiContentType;

    return-object v0
.end method
