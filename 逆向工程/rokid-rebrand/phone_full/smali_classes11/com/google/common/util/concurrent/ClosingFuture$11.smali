.class Lcom/google/common/util/concurrent/ClosingFuture$11;
.super Ljava/lang/Object;
.source "ClosingFuture.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/google/common/util/concurrent/ClosingFuture;->closeQuietly(Ljava/lang/AutoCloseable;Ljava/util/concurrent/Executor;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$closeable:Ljava/lang/AutoCloseable;


# direct methods
.method constructor <init>(Ljava/lang/AutoCloseable;)V
    .locals 0

    .line 2102
    iput-object p1, p0, Lcom/google/common/util/concurrent/ClosingFuture$11;->val$closeable:Ljava/lang/AutoCloseable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .line 2106
    :try_start_0
    iget-object v0, p0, Lcom/google/common/util/concurrent/ClosingFuture$11;->val$closeable:Ljava/lang/AutoCloseable;

    invoke-interface {v0}, Ljava/lang/AutoCloseable;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 2109
    goto :goto_0

    .line 2107
    :catch_0
    move-exception v0

    .line 2108
    .local v0, "e":Ljava/lang/Exception;
    invoke-static {}, Lcom/google/common/util/concurrent/ClosingFuture;->access$3200()Ljava/util/logging/Logger;

    move-result-object v1

    sget-object v2, Ljava/util/logging/Level;->WARNING:Ljava/util/logging/Level;

    const-string v3, "thrown by close()"

    invoke-virtual {v1, v2, v3, v0}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 2110
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method
