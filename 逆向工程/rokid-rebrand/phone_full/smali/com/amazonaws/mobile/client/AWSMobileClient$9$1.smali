.class Lcom/amazonaws/mobile/client/AWSMobileClient$9$1;
.super Ljava/lang/Object;
.source "AWSMobileClient.java"

# interfaces
.implements Lcom/amazonaws/mobile/client/Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/amazonaws/mobile/client/AWSMobileClient$9;->run()Ljava/lang/Void;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/amazonaws/mobile/client/Callback<",
        "Ljava/lang/Void;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$9;

.field final synthetic val$latch:Ljava/util/concurrent/CountDownLatch;

.field final synthetic val$signOutError:[Ljava/lang/Exception;


# direct methods
.method constructor <init>(Lcom/amazonaws/mobile/client/AWSMobileClient$9;Ljava/util/concurrent/CountDownLatch;[Ljava/lang/Exception;)V
    .locals 0
    .param p1, "this$1"    # Lcom/amazonaws/mobile/client/AWSMobileClient$9;

    .line 1568
    iput-object p1, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9$1;->this$1:Lcom/amazonaws/mobile/client/AWSMobileClient$9;

    iput-object p2, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9$1;->val$latch:Ljava/util/concurrent/CountDownLatch;

    iput-object p3, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9$1;->val$signOutError:[Ljava/lang/Exception;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError(Ljava/lang/Exception;)V
    .locals 2
    .param p1, "e"    # Ljava/lang/Exception;

    .line 1576
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9$1;->val$signOutError:[Ljava/lang/Exception;

    const/4 v1, 0x0

    aput-object p1, v0, v1

    .line 1577
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9$1;->val$latch:Ljava/util/concurrent/CountDownLatch;

    invoke-virtual {v0}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    .line 1578
    return-void
.end method

.method public bridge synthetic onResult(Ljava/lang/Object;)V
    .locals 0

    .line 1568
    check-cast p1, Ljava/lang/Void;

    invoke-virtual {p0, p1}, Lcom/amazonaws/mobile/client/AWSMobileClient$9$1;->onResult(Ljava/lang/Void;)V

    return-void
.end method

.method public onResult(Ljava/lang/Void;)V
    .locals 1
    .param p1, "result"    # Ljava/lang/Void;

    .line 1571
    iget-object v0, p0, Lcom/amazonaws/mobile/client/AWSMobileClient$9$1;->val$latch:Ljava/util/concurrent/CountDownLatch;

    invoke-virtual {v0}, Ljava/util/concurrent/CountDownLatch;->countDown()V

    .line 1572
    return-void
.end method
