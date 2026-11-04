.class public final Lcom/rokid/security/sdk/base/common/AiIntent;
.super Ljava/lang/Object;
.source "AiChatExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u0014\u0010\u0003\u001a\u00020\u0004X\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\u00a8\u0006\u0007"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/AiIntent;",
        "",
        "()V",
        "IMAGE",
        "",
        "getIMAGE",
        "()Ljava/lang/String;",
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
.field private static final IMAGE:Ljava/lang/String;

.field public static final INSTANCE:Lcom/rokid/security/sdk/base/common/AiIntent;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/base/common/AiIntent;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/AiIntent;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/base/common/AiIntent;->INSTANCE:Lcom/rokid/security/sdk/base/common/AiIntent;

    .line 139
    const-string v0, "image_recognition"

    sput-object v0, Lcom/rokid/security/sdk/base/common/AiIntent;->IMAGE:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 136
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getIMAGE()Ljava/lang/String;
    .locals 1

    .line 139
    sget-object v0, Lcom/rokid/security/sdk/base/common/AiIntent;->IMAGE:Ljava/lang/String;

    return-object v0
.end method
