.class Lcom/google/common/cache/LocalCache$ComputingValueReference;
.super Lcom/google/common/cache/LocalCache$LoadingValueReference;
.source "LocalCache.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/common/cache/LocalCache;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "ComputingValueReference"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<K:",
        "Ljava/lang/Object;",
        "V:",
        "Ljava/lang/Object;",
        ">",
        "Lcom/google/common/cache/LocalCache$LoadingValueReference<",
        "TK;TV;>;"
    }
.end annotation


# direct methods
.method constructor <init>(Lcom/google/common/cache/LocalCache$ValueReference;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/common/cache/LocalCache$ValueReference<",
            "TK;TV;>;)V"
        }
    .end annotation

    .line 3608
    .local p0, "this":Lcom/google/common/cache/LocalCache$ComputingValueReference;, "Lcom/google/common/cache/LocalCache$ComputingValueReference<TK;TV;>;"
    .local p1, "oldValue":Lcom/google/common/cache/LocalCache$ValueReference;, "Lcom/google/common/cache/LocalCache$ValueReference<TK;TV;>;"
    invoke-direct {p0, p1}, Lcom/google/common/cache/LocalCache$LoadingValueReference;-><init>(Lcom/google/common/cache/LocalCache$ValueReference;)V

    .line 3609
    return-void
.end method


# virtual methods
.method public isLoading()Z
    .locals 1

    .line 3613
    .local p0, "this":Lcom/google/common/cache/LocalCache$ComputingValueReference;, "Lcom/google/common/cache/LocalCache$ComputingValueReference<TK;TV;>;"
    const/4 v0, 0x0

    return v0
.end method
