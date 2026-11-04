.class public final synthetic Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Function;


# instance fields
.field public final synthetic f$0:Lkotlin/jvm/functions/Function1;


# direct methods
.method public synthetic constructor <init>(Lkotlin/jvm/functions/Function1;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$$ExternalSyntheticLambda1;->f$0:Lkotlin/jvm/functions/Function1;

    return-void
.end method


# virtual methods
.method public final apply(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$$ExternalSyntheticLambda1;->f$0:Lkotlin/jvm/functions/Function1;

    invoke-static {v0, p1}, Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher;->$r8$lambda$OLZ-XWEXtNkGyu6zxq1uILrZ_4U(Lkotlin/jvm/functions/Function1;Ljava/lang/Object;)Lcom/rokid/security/sdk/ability/concurrent/BoundedLatestTaskDispatcher$Lane;

    move-result-object p1

    return-object p1
.end method
