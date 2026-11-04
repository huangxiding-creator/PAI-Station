.class public Lcom/amazonaws/auth/policy/Condition;
.super Ljava/lang/Object;
.source "Condition.java"


# instance fields
.field protected conditionKey:Ljava/lang/String;

.field protected type:Ljava/lang/String;

.field protected values:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 64
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getConditionKey()Ljava/lang/String;
    .locals 1

    .line 100
    iget-object v0, p0, Lcom/amazonaws/auth/policy/Condition;->conditionKey:Ljava/lang/String;

    return-object v0
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    .line 75
    iget-object v0, p0, Lcom/amazonaws/auth/policy/Condition;->type:Ljava/lang/String;

    return-object v0
.end method

.method public getValues()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 131
    iget-object v0, p0, Lcom/amazonaws/auth/policy/Condition;->values:Ljava/util/List;

    return-object v0
.end method

.method public setConditionKey(Ljava/lang/String;)V
    .locals 0
    .param p1, "conditionKey"    # Ljava/lang/String;

    .line 117
    iput-object p1, p0, Lcom/amazonaws/auth/policy/Condition;->conditionKey:Ljava/lang/String;

    .line 118
    return-void
.end method

.method public setType(Ljava/lang/String;)V
    .locals 0
    .param p1, "type"    # Ljava/lang/String;

    .line 84
    iput-object p1, p0, Lcom/amazonaws/auth/policy/Condition;->type:Ljava/lang/String;

    .line 85
    return-void
.end method

.method public setValues(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 146
    .local p1, "values":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/auth/policy/Condition;->values:Ljava/util/List;

    .line 147
    return-void
.end method

.method public withConditionKey(Ljava/lang/String;)Lcom/amazonaws/auth/policy/Condition;
    .locals 0
    .param p1, "key"    # Ljava/lang/String;

    .line 166
    invoke-virtual {p0, p1}, Lcom/amazonaws/auth/policy/Condition;->setConditionKey(Ljava/lang/String;)V

    .line 167
    return-object p0
.end method

.method public withType(Ljava/lang/String;)Lcom/amazonaws/auth/policy/Condition;
    .locals 0
    .param p1, "type"    # Ljava/lang/String;

    .line 156
    invoke-virtual {p0, p1}, Lcom/amazonaws/auth/policy/Condition;->setType(Ljava/lang/String;)V

    .line 157
    return-object p0
.end method

.method public withValues(Ljava/util/List;)Lcom/amazonaws/auth/policy/Condition;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/auth/policy/Condition;"
        }
    .end annotation

    .line 188
    .local p1, "values":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/auth/policy/Condition;->setValues(Ljava/util/List;)V

    .line 189
    return-object p0
.end method

.method public varargs withValues([Ljava/lang/String;)Lcom/amazonaws/auth/policy/Condition;
    .locals 1
    .param p1, "values"    # [Ljava/lang/String;

    .line 177
    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/amazonaws/auth/policy/Condition;->setValues(Ljava/util/List;)V

    .line 178
    return-object p0
.end method
