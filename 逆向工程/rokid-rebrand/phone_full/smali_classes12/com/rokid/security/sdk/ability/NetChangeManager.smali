.class public final Lcom/rokid/security/sdk/ability/NetChangeManager;
.super Ljava/lang/Object;
.source "NetChangeManager.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0002\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0005\u001a\u00020\u0004J\u000e\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\u0004R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\t"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/NetChangeManager;",
        "",
        "()V",
        "networkMode",
        "",
        "getNetworkMode",
        "setNetworkMode",
        "",
        "type",
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/NetChangeManager;

.field private static networkMode:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/NetChangeManager;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/NetChangeManager;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/NetChangeManager;->INSTANCE:Lcom/rokid/security/sdk/ability/NetChangeManager;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getNetworkMode()I
    .locals 1

    .line 18
    sget v0, Lcom/rokid/security/sdk/ability/NetChangeManager;->networkMode:I

    return v0
.end method

.method public final setNetworkMode(I)V
    .locals 0
    .param p1, "type"    # I

    .line 13
    sput p1, Lcom/rokid/security/sdk/ability/NetChangeManager;->networkMode:I

    .line 14
    return-void
.end method
