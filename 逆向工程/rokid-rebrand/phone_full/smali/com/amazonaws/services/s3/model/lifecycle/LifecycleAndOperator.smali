.class public final Lcom/amazonaws/services/s3/model/lifecycle/LifecycleAndOperator;
.super Lcom/amazonaws/services/s3/model/lifecycle/LifecycleNAryOperator;
.source "LifecycleAndOperator.java"


# direct methods
.method public constructor <init>(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilterPredicate;",
            ">;)V"
        }
    .end annotation

    .line 32
    .local p1, "operands":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/lifecycle/LifecycleFilterPredicate;>;"
    invoke-direct {p0, p1}, Lcom/amazonaws/services/s3/model/lifecycle/LifecycleNAryOperator;-><init>(Ljava/util/List;)V

    .line 33
    return-void
.end method


# virtual methods
.method public accept(Lcom/amazonaws/services/s3/model/lifecycle/LifecyclePredicateVisitor;)V
    .locals 0
    .param p1, "lifecyclePredicateVisitor"    # Lcom/amazonaws/services/s3/model/lifecycle/LifecyclePredicateVisitor;

    .line 37
    invoke-interface {p1, p0}, Lcom/amazonaws/services/s3/model/lifecycle/LifecyclePredicateVisitor;->visit(Lcom/amazonaws/services/s3/model/lifecycle/LifecycleAndOperator;)V

    .line 38
    return-void
.end method

.method public bridge synthetic getOperands()Ljava/util/List;
    .locals 1

    .line 25
    invoke-super {p0}, Lcom/amazonaws/services/s3/model/lifecycle/LifecycleNAryOperator;->getOperands()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method
