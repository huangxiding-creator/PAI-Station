.class public Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilter;
.super Ljava/lang/Object;
.source "LifecycleFilter.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private predicate:Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilterPredicate;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilterPredicate;)V
    .locals 0
    .param p1, "predicate"    # Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilterPredicate;

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilter;->predicate:Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilterPredicate;

    .line 40
    return-void
.end method


# virtual methods
.method public getPredicate()Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilterPredicate;
    .locals 1

    .line 50
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilter;->predicate:Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilterPredicate;

    return-object v0
.end method

.method public setPredicate(Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilterPredicate;)V
    .locals 0
    .param p1, "predicate"    # Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilterPredicate;

    .line 63
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilter;->predicate:Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilterPredicate;

    .line 64
    return-void
.end method

.method public withPredicate(Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilterPredicate;)Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilter;
    .locals 0
    .param p1, "predicate"    # Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilterPredicate;

    .line 80
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilter;->setPredicate(Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilterPredicate;)V

    .line 81
    return-object p0
.end method
