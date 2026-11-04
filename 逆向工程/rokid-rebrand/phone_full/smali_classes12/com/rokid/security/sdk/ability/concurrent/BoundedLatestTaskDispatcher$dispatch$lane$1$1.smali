.class final Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$dispatch$lane$1$1;
.super Lkotlin/jvm/internal/Lambda;
.source "BoundedLatestTaskDispatcher.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->dispatch(Ljava/lang/Object;Lkotlin/jvm/functions/Function0;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "TK;",
        "Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher<",
        "TK;>.",
        "Lane;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0004\u0010\u0000\u001a\u000c0\u0001R\u0008\u0012\u0004\u0012\u0002H\u00030\u0002\"\u0004\u0008\u0000\u0010\u00032\u0006\u0010\u0004\u001a\u0002H\u0003H\n\u00a2\u0006\u0004\u0008\u0005\u0010\u0006"
    }
    d2 = {
        "<anonymous>",
        "Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;",
        "Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;",
        "K",
        "it",
        "invoke",
        "(Ljava/lang/Object;)Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $key:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TK;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher<",
            "TK;>;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher<",
            "TK;>;TK;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$dispatch$lane$1$1;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    iput-object p2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$dispatch$lane$1$1;->$key:Ljava/lang/Object;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public final invoke(Ljava/lang/Object;)Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;
    .locals 3
    .param p1, "it"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;)",
            "Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher<",
            "TK;>.",
            "Lane;"
        }
    .end annotation

    .line 53
    new-instance v0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$dispatch$lane$1$1;->this$0:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$dispatch$lane$1$1;->$key:Ljava/lang/Object;

    invoke-direct {v0, v1, v2}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;-><init>(Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Ljava/lang/Object;)V

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 53
    invoke-virtual {p0, p1}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$dispatch$lane$1$1;->invoke(Ljava/lang/Object;)Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;

    move-result-object v0

    return-object v0
.end method
