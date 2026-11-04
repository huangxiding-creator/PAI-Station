.class public final Lcom/rokid/security/sdk/ability/message/MessageReceiver;
.super Ljava/lang/Object;
.source "MessageReceiver.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0012\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0003\u001a\u00020\u0004\u00a8\u0006\u0005"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/message/MessageReceiver;",
        "",
        "()V",
        "getMessageAction",
        "Lcom/rokid/security/sdk/ability/message/IMessageAction;",
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageReceiver;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/message/MessageReceiver;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/message/MessageReceiver;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/message/MessageReceiver;->INSTANCE:Lcom/rokid/security/sdk/ability/message/MessageReceiver;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getMessageAction()Lcom/rokid/security/sdk/ability/message/IMessageAction;
    .locals 1

    .line 11
    sget-object v0, Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;->INSTANCE:Lcom/rokid/security/sdk/ability/message/CommonMessageImpl;

    check-cast v0, Lcom/rokid/security/sdk/ability/message/IMessageAction;

    return-object v0
.end method
