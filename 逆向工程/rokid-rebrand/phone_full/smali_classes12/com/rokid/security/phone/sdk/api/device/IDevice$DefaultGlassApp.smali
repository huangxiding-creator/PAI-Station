.class public final enum Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;
.super Ljava/lang/Enum;
.source "IDevice.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/device/IDevice;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "DefaultGlassApp"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0012\n\u0002\u0018\u0002\n\u0002\u0010\u0010\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\n\u0008\u0086\u0001\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00000\u0001B\u000f\u0008\u0002\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006j\u0002\u0008\u0007j\u0002\u0008\u0008j\u0002\u0008\tj\u0002\u0008\nj\u0002\u0008\u000bj\u0002\u0008\u000c\u00a8\u0006\r"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;",
        "",
        "appKey",
        "",
        "(Ljava/lang/String;ILjava/lang/String;)V",
        "getAppKey",
        "()Ljava/lang/String;",
        "AI_ASSISTANT",
        "AI_INDUSTRY",
        "AI_CHAT",
        "OFFLINE_RECOGNIZE",
        "LPR",
        "TAKE_PHOTO",
        "sdk-api_release"
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
.field private static final synthetic $VALUES:[Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

.field public static final enum AI_ASSISTANT:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

.field public static final enum AI_CHAT:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

.field public static final enum AI_INDUSTRY:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

.field public static final enum LPR:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

.field public static final enum OFFLINE_RECOGNIZE:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

.field public static final enum TAKE_PHOTO:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;


# instance fields
.field private final appKey:Ljava/lang/String;


# direct methods
.method private static final synthetic $values()[Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;
    .locals 6

    sget-object v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->AI_ASSISTANT:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    sget-object v1, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->AI_INDUSTRY:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    sget-object v2, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->AI_CHAT:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    sget-object v3, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->OFFLINE_RECOGNIZE:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    sget-object v4, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->LPR:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    sget-object v5, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->TAKE_PHOTO:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    filled-new-array/range {v0 .. v5}, [Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 4

    .line 30
    new-instance v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    const/4 v1, 0x0

    const-string v2, "aiAssistant"

    const-string v3, "AI_ASSISTANT"

    invoke-direct {v0, v3, v1, v2}, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->AI_ASSISTANT:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    .line 31
    new-instance v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    const/4 v1, 0x1

    const-string v2, "aiIndustry"

    const-string v3, "AI_INDUSTRY"

    invoke-direct {v0, v3, v1, v2}, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->AI_INDUSTRY:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    .line 32
    new-instance v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    const/4 v1, 0x2

    const-string/jumbo v2, "safetyInspection"

    const-string v3, "AI_CHAT"

    invoke-direct {v0, v3, v1, v2}, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->AI_CHAT:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    .line 33
    new-instance v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    const/4 v1, 0x3

    const-string v2, "offlineFace"

    const-string v3, "OFFLINE_RECOGNIZE"

    invoke-direct {v0, v3, v1, v2}, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->OFFLINE_RECOGNIZE:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    .line 34
    new-instance v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    const/4 v1, 0x4

    const-string v2, "lprDetection"

    const-string v3, "LPR"

    invoke-direct {v0, v3, v1, v2}, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->LPR:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    .line 35
    new-instance v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    const/4 v1, 0x5

    const-string/jumbo v2, "takephoto"

    const-string v3, "TAKE_PHOTO"

    invoke-direct {v0, v3, v1, v2}, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->TAKE_PHOTO:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    invoke-static {}, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->$values()[Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->$VALUES:[Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p1, "$enum$name"    # Ljava/lang/String;
    .param p2, "$enum$ordinal"    # I
    .param p3, "appKey"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 29
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->appKey:Ljava/lang/String;

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;
    .locals 1

    const-class v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    return-object v0
.end method

.method public static values()[Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;
    .locals 1

    sget-object v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->$VALUES:[Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    invoke-virtual {v0}, [Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    return-object v0
.end method


# virtual methods
.method public final getAppKey()Ljava/lang/String;
    .locals 1

    .line 29
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->appKey:Ljava/lang/String;

    return-object v0
.end method
