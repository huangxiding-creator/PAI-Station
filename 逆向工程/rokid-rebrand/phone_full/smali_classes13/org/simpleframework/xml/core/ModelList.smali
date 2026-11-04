.class Lorg/simpleframework/xml/core/ModelList;
.super Ljava/util/ArrayList;
.source "ModelList.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/util/ArrayList<",
        "Lorg/simpleframework/xml/core/Model;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Ljava/util/ArrayList;-><init>()V

    .line 43
    return-void
.end method


# virtual methods
.method public build()Lorg/simpleframework/xml/core/ModelList;
    .locals 3

    .line 53
    new-instance v0, Lorg/simpleframework/xml/core/ModelList;

    invoke-direct {v0}, Lorg/simpleframework/xml/core/ModelList;-><init>()V

    .line 55
    .local v0, "list":Lorg/simpleframework/xml/core/ModelList;
    invoke-virtual {p0}, Lorg/simpleframework/xml/core/ModelList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/simpleframework/xml/core/Model;

    .line 56
    .local v2, "model":Lorg/simpleframework/xml/core/Model;
    invoke-virtual {v0, v2}, Lorg/simpleframework/xml/core/ModelList;->register(Lorg/simpleframework/xml/core/Model;)V

    .line 57
    .end local v2    # "model":Lorg/simpleframework/xml/core/Model;
    goto :goto_0

    .line 58
    :cond_0
    return-object v0
.end method

.method public isEmpty()Z
    .locals 3

    .line 70
    invoke-virtual {p0}, Lorg/simpleframework/xml/core/ModelList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/simpleframework/xml/core/Model;

    .line 71
    .local v1, "model":Lorg/simpleframework/xml/core/Model;
    if-eqz v1, :cond_0

    .line 72
    invoke-interface {v1}, Lorg/simpleframework/xml/core/Model;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    .line 73
    const/4 v0, 0x0

    return v0

    .line 76
    .end local v1    # "model":Lorg/simpleframework/xml/core/Model;
    :cond_0
    goto :goto_0

    .line 77
    :cond_1
    const/4 v0, 0x1

    return v0
.end method

.method public lookup(I)Lorg/simpleframework/xml/core/Model;
    .locals 2
    .param p1, "index"    # I

    .line 90
    invoke-virtual {p0}, Lorg/simpleframework/xml/core/ModelList;->size()I

    move-result v0

    .line 92
    .local v0, "size":I
    if-gt p1, v0, :cond_0

    .line 93
    add-int/lit8 v1, p1, -0x1

    invoke-virtual {p0, v1}, Lorg/simpleframework/xml/core/ModelList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/simpleframework/xml/core/Model;

    return-object v1

    .line 95
    :cond_0
    const/4 v1, 0x0

    return-object v1
.end method

.method public register(Lorg/simpleframework/xml/core/Model;)V
    .locals 4
    .param p1, "model"    # Lorg/simpleframework/xml/core/Model;

    .line 108
    invoke-interface {p1}, Lorg/simpleframework/xml/core/Model;->getIndex()I

    move-result v0

    .line 109
    .local v0, "index":I
    invoke-virtual {p0}, Lorg/simpleframework/xml/core/ModelList;->size()I

    move-result v1

    .line 111
    .local v1, "size":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v0, :cond_2

    .line 112
    if-lt v2, v1, :cond_0

    .line 113
    const/4 v3, 0x0

    invoke-virtual {p0, v3}, Lorg/simpleframework/xml/core/ModelList;->add(Ljava/lang/Object;)Z

    .line 115
    :cond_0
    add-int/lit8 v3, v0, -0x1

    if-ne v2, v3, :cond_1

    .line 116
    add-int/lit8 v3, v0, -0x1

    invoke-virtual {p0, v3, p1}, Lorg/simpleframework/xml/core/ModelList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 111
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 119
    .end local v2    # "i":I
    :cond_2
    return-void
.end method

.method public take()Lorg/simpleframework/xml/core/Model;
    .locals 2

    .line 129
    nop

    :goto_0
    invoke-virtual {p0}, Lorg/simpleframework/xml/core/ModelList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 130
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lorg/simpleframework/xml/core/ModelList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/simpleframework/xml/core/Model;

    .line 132
    .local v0, "model":Lorg/simpleframework/xml/core/Model;
    invoke-interface {v0}, Lorg/simpleframework/xml/core/Model;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 133
    return-object v0

    .line 135
    .end local v0    # "model":Lorg/simpleframework/xml/core/Model;
    :cond_0
    goto :goto_0

    .line 136
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method
