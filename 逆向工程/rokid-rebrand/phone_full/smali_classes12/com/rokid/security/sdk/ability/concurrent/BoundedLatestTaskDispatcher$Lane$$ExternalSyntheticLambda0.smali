.class public final synthetic Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lkotlin/jvm/functions/Function0;

.field public final synthetic f$1:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

.field public final synthetic f$2:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;

.field public final synthetic f$3:Ljava/util/concurrent/CountDownLatch;


# direct methods
.method public synthetic constructor <init>(Lkotlin/jvm/functions/Function0;Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;Ljava/util/concurrent/CountDownLatch;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane$$ExternalSyntheticLambda0;->f$0:Lkotlin/jvm/functions/Function0;

    iput-object p2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane$$ExternalSyntheticLambda0;->f$1:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    iput-object p3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane$$ExternalSyntheticLambda0;->f$2:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;

    iput-object p4, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane$$ExternalSyntheticLambda0;->f$3:Ljava/util/concurrent/CountDownLatch;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    .line 0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane$$ExternalSyntheticLambda0;->f$0:Lkotlin/jvm/functions/Function0;

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane$$ExternalSyntheticLambda0;->f$1:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane$$ExternalSyntheticLambda0;->f$2:Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;

    iget-object v3, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane$$ExternalSyntheticLambda0;->f$3:Ljava/util/concurrent/CountDownLatch;

    invoke-static {v0, v1, v2, v3}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;->$r8$lambda$4rHmwCRvaPqK62lHrwX26abSHvw(Lkotlin/jvm/functions/Function0;Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;Ljava/util/concurrent/CountDownLatch;)V

    return-void
.end method
