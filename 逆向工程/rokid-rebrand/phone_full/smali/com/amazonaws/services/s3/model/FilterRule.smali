.class public Lcom/amazonaws/services/s3/model/FilterRule;
.super Ljava/lang/Object;
.source "FilterRule.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private name:Ljava/lang/String;

.field private value:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getName()Ljava/lang/String;
    .locals 1

    .line 32
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/FilterRule;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getValue()Ljava/lang/String;
    .locals 1

    .line 66
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/FilterRule;->value:Ljava/lang/String;

    return-object v0
.end method

.method public setName(Ljava/lang/String;)V
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 42
    if-eqz p1, :cond_0

    .line 45
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/FilterRule;->name:Ljava/lang/String;

    .line 46
    return-void

    .line 43
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "FilterRule Name is a required argument"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setValue(Ljava/lang/String;)V
    .locals 0
    .param p1, "value"    # Ljava/lang/String;

    .line 76
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/FilterRule;->value:Ljava/lang/String;

    .line 77
    return-void
.end method

.method public withName(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/FilterRule;
    .locals 0
    .param p1, "name"    # Ljava/lang/String;

    .line 56
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/FilterRule;->setName(Ljava/lang/String;)V

    .line 57
    return-object p0
.end method

.method public withValue(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/FilterRule;
    .locals 0
    .param p1, "value"    # Ljava/lang/String;

    .line 87
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/FilterRule;->setValue(Ljava/lang/String;)V

    .line 88
    return-object p0
.end method
