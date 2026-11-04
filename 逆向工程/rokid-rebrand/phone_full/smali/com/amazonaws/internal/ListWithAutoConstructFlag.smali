.class public Lcom/amazonaws/internal/ListWithAutoConstructFlag;
.super Ljava/util/ArrayList;
.source "ListWithAutoConstructFlag.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/util/ArrayList<",
        "TT;>;"
    }
.end annotation


# static fields
.field private static final serialVersionUID:J = 0x1L


# instance fields
.field private autoConstruct:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 36
    .local p0, "this":Lcom/amazonaws/internal/ListWithAutoConstructFlag;, "Lcom/amazonaws/internal/ListWithAutoConstructFlag<TT;>;"
    invoke-direct {p0}, Ljava/util/ArrayList;-><init>()V

    .line 37
    return-void
.end method

.method public constructor <init>(I)V
    .locals 0
    .param p1, "initialCapacity"    # I

    .line 44
    .local p0, "this":Lcom/amazonaws/internal/ListWithAutoConstructFlag;, "Lcom/amazonaws/internal/ListWithAutoConstructFlag<TT;>;"
    invoke-direct {p0, p1}, Ljava/util/ArrayList;-><init>(I)V

    .line 45
    return-void
.end method

.method public constructor <init>(Ljava/util/Collection;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "+TT;>;)V"
        }
    .end annotation

    .line 40
    .local p0, "this":Lcom/amazonaws/internal/ListWithAutoConstructFlag;, "Lcom/amazonaws/internal/ListWithAutoConstructFlag<TT;>;"
    .local p1, "c":Ljava/util/Collection;, "Ljava/util/Collection<+TT;>;"
    invoke-direct {p0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 41
    return-void
.end method


# virtual methods
.method public isAutoConstruct()Z
    .locals 1

    .line 55
    .local p0, "this":Lcom/amazonaws/internal/ListWithAutoConstructFlag;, "Lcom/amazonaws/internal/ListWithAutoConstructFlag<TT;>;"
    iget-boolean v0, p0, Lcom/amazonaws/internal/ListWithAutoConstructFlag;->autoConstruct:Z

    return v0
.end method

.method public setAutoConstruct(Z)V
    .locals 0
    .param p1, "autoConstruct"    # Z

    .line 48
    .local p0, "this":Lcom/amazonaws/internal/ListWithAutoConstructFlag;, "Lcom/amazonaws/internal/ListWithAutoConstructFlag<TT;>;"
    iput-boolean p1, p0, Lcom/amazonaws/internal/ListWithAutoConstructFlag;->autoConstruct:Z

    .line 49
    return-void
.end method
