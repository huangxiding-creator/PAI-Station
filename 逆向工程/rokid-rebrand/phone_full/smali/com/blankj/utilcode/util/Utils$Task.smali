.class public abstract Lcom/blankj/utilcode/util/Utils$Task;
.super Lcom/blankj/utilcode/util/ThreadUtils$SimpleTask;
.source "Utils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/blankj/utilcode/util/Utils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Task"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<Result:",
        "Ljava/lang/Object;",
        ">",
        "Lcom/blankj/utilcode/util/ThreadUtils$SimpleTask<",
        "TResult;>;"
    }
.end annotation


# instance fields
.field private mConsumer:Lcom/blankj/utilcode/util/Utils$Consumer;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/blankj/utilcode/util/Utils$Consumer<",
            "TResult;>;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lcom/blankj/utilcode/util/Utils$Consumer;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/blankj/utilcode/util/Utils$Consumer<",
            "TResult;>;)V"
        }
    .end annotation

    .line 85
    .local p0, "this":Lcom/blankj/utilcode/util/Utils$Task;, "Lcom/blankj/utilcode/util/Utils$Task<TResult;>;"
    .local p1, "consumer":Lcom/blankj/utilcode/util/Utils$Consumer;, "Lcom/blankj/utilcode/util/Utils$Consumer<TResult;>;"
    invoke-direct {p0}, Lcom/blankj/utilcode/util/ThreadUtils$SimpleTask;-><init>()V

    .line 86
    iput-object p1, p0, Lcom/blankj/utilcode/util/Utils$Task;->mConsumer:Lcom/blankj/utilcode/util/Utils$Consumer;

    .line 87
    return-void
.end method


# virtual methods
.method public onSuccess(Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TResult;)V"
        }
    .end annotation

    .line 91
    .local p0, "this":Lcom/blankj/utilcode/util/Utils$Task;, "Lcom/blankj/utilcode/util/Utils$Task<TResult;>;"
    .local p1, "result":Ljava/lang/Object;, "TResult;"
    iget-object v0, p0, Lcom/blankj/utilcode/util/Utils$Task;->mConsumer:Lcom/blankj/utilcode/util/Utils$Consumer;

    if-eqz v0, :cond_0

    .line 92
    iget-object v0, p0, Lcom/blankj/utilcode/util/Utils$Task;->mConsumer:Lcom/blankj/utilcode/util/Utils$Consumer;

    invoke-interface {v0, p1}, Lcom/blankj/utilcode/util/Utils$Consumer;->accept(Ljava/lang/Object;)V

    .line 94
    :cond_0
    return-void
.end method
