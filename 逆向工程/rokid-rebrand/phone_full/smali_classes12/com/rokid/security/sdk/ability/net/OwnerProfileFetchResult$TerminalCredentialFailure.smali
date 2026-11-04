.class public final Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$TerminalCredentialFailure;
.super Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;
.source "OwnerProfileClient.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "TerminalCredentialFailure"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000c\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002\u00a8\u0006\u0003"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$TerminalCredentialFailure;",
        "Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;",
        "()V",
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$TerminalCredentialFailure;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$TerminalCredentialFailure;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$TerminalCredentialFailure;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$TerminalCredentialFailure;->INSTANCE:Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$TerminalCredentialFailure;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 121
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-void
.end method
