.class public final Lcom/rokid/security/sdk/ability/message/MessageType;
.super Ljava/lang/Object;
.source "ICommonMessage.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0007\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R\u0014\u0010\u0003\u001a\u00020\u0004X\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006R\u0014\u0010\u0007\u001a\u00020\u0004X\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0008\u0010\u0006R\u0014\u0010\t\u001a\u00020\u0004X\u0086D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\n\u0010\u0006\u00a8\u0006\u000b"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/message/MessageType;",
        "",
        "()V",
        "BT",
        "",
        "getBT",
        "()I",
        "P2P",
        "getP2P",
        "WIFI",
        "getWIFI",
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
.field private static final BT:I

.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageType;

.field private static final P2P:I

.field private static final WIFI:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/message/MessageType;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/message/MessageType;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/message/MessageType;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageType;

    .line 9
    const/4 v0, 0x1

    sput v0, Lcom/rokid/security/sdk/ability/message/MessageType;->BT:I

    .line 10
    const/4 v0, 0x2

    sput v0, Lcom/rokid/security/sdk/ability/message/MessageType;->P2P:I

    .line 11
    const/4 v0, 0x3

    sput v0, Lcom/rokid/security/sdk/ability/message/MessageType;->WIFI:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getBT()I
    .locals 1

    .line 9
    sget v0, Lcom/rokid/security/sdk/ability/message/MessageType;->BT:I

    return v0
.end method

.method public final getP2P()I
    .locals 1

    .line 10
    sget v0, Lcom/rokid/security/sdk/ability/message/MessageType;->P2P:I

    return v0
.end method

.method public final getWIFI()I
    .locals 1

    .line 11
    sget v0, Lcom/rokid/security/sdk/ability/message/MessageType;->WIFI:I

    return v0
.end method
