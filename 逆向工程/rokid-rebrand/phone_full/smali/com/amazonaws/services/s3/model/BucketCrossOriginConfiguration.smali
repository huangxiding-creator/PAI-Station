.class public Lcom/amazonaws/services/s3/model/BucketCrossOriginConfiguration;
.super Ljava/lang/Object;
.source "BucketCrossOriginConfiguration.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private rules:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/CORSRule;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 75
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 76
    return-void
.end method

.method public constructor <init>(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/CORSRule;",
            ">;)V"
        }
    .end annotation

    .line 70
    .local p1, "rules":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/CORSRule;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 71
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/BucketCrossOriginConfiguration;->rules:Ljava/util/List;

    .line 72
    return-void
.end method


# virtual methods
.method public getRules()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/CORSRule;",
            ">;"
        }
    .end annotation

    .line 36
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/BucketCrossOriginConfiguration;->rules:Ljava/util/List;

    return-object v0
.end method

.method public setRules(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/CORSRule;",
            ">;)V"
        }
    .end annotation

    .line 43
    .local p1, "rules":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/CORSRule;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/BucketCrossOriginConfiguration;->rules:Ljava/util/List;

    .line 44
    return-void
.end method

.method public withRules(Ljava/util/List;)Lcom/amazonaws/services/s3/model/BucketCrossOriginConfiguration;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/CORSRule;",
            ">;)",
            "Lcom/amazonaws/services/s3/model/BucketCrossOriginConfiguration;"
        }
    .end annotation

    .line 51
    .local p1, "rules":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/CORSRule;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/BucketCrossOriginConfiguration;->setRules(Ljava/util/List;)V

    .line 52
    return-object p0
.end method

.method public varargs withRules([Lcom/amazonaws/services/s3/model/CORSRule;)Lcom/amazonaws/services/s3/model/BucketCrossOriginConfiguration;
    .locals 1
    .param p1, "rules"    # [Lcom/amazonaws/services/s3/model/CORSRule;

    .line 60
    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/amazonaws/services/s3/model/BucketCrossOriginConfiguration;->setRules(Ljava/util/List;)V

    .line 61
    return-object p0
.end method
