.class Lorg/simpleframework/xml/core/ModelAssembler;
.super Ljava/lang/Object;
.source "ModelAssembler.java"


# instance fields
.field private final builder:Lorg/simpleframework/xml/core/ExpressionBuilder;

.field private final detail:Lorg/simpleframework/xml/core/Detail;

.field private final format:Lorg/simpleframework/xml/stream/Format;


# direct methods
.method public constructor <init>(Lorg/simpleframework/xml/core/ExpressionBuilder;Lorg/simpleframework/xml/core/Detail;Lorg/simpleframework/xml/core/Support;)V
    .locals 1
    .param p1, "builder"    # Lorg/simpleframework/xml/core/ExpressionBuilder;
    .param p2, "detail"    # Lorg/simpleframework/xml/core/Detail;
    .param p3, "support"    # Lorg/simpleframework/xml/core/Support;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 73
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 74
    invoke-virtual {p3}, Lorg/simpleframework/xml/core/Support;->getFormat()Lorg/simpleframework/xml/stream/Format;

    move-result-object v0

    iput-object v0, p0, Lorg/simpleframework/xml/core/ModelAssembler;->format:Lorg/simpleframework/xml/stream/Format;

    .line 75
    iput-object p1, p0, Lorg/simpleframework/xml/core/ModelAssembler;->builder:Lorg/simpleframework/xml/core/ExpressionBuilder;

    .line 76
    iput-object p2, p0, Lorg/simpleframework/xml/core/ModelAssembler;->detail:Lorg/simpleframework/xml/core/Detail;

    .line 77
    return-void
.end method

.method private assembleAttributes(Lorg/simpleframework/xml/core/Model;Lorg/simpleframework/xml/Order;)V
    .locals 7
    .param p1, "model"    # Lorg/simpleframework/xml/core/Model;
    .param p2, "order"    # Lorg/simpleframework/xml/Order;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 123
    invoke-interface {p2}, Lorg/simpleframework/xml/Order;->attributes()[Ljava/lang/String;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_3

    aget-object v3, v0, v2

    .line 124
    .local v3, "value":Ljava/lang/String;
    iget-object v4, p0, Lorg/simpleframework/xml/core/ModelAssembler;->builder:Lorg/simpleframework/xml/core/ExpressionBuilder;

    invoke-virtual {v4, v3}, Lorg/simpleframework/xml/core/ExpressionBuilder;->build(Ljava/lang/String;)Lorg/simpleframework/xml/core/Expression;

    move-result-object v4

    .line 126
    .local v4, "path":Lorg/simpleframework/xml/core/Expression;
    invoke-interface {v4}, Lorg/simpleframework/xml/core/Expression;->isAttribute()Z

    move-result v5

    if-nez v5, :cond_1

    invoke-interface {v4}, Lorg/simpleframework/xml/core/Expression;->isPath()Z

    move-result v5

    if-nez v5, :cond_0

    goto :goto_1

    .line 127
    :cond_0
    new-instance v0, Lorg/simpleframework/xml/core/PathException;

    iget-object v1, p0, Lorg/simpleframework/xml/core/ModelAssembler;->detail:Lorg/simpleframework/xml/core/Detail;

    filled-new-array {v4, v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "Ordered attribute \'%s\' references an element in %s"

    invoke-direct {v0, v2, v1}, Lorg/simpleframework/xml/core/PathException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 129
    :cond_1
    :goto_1
    invoke-interface {v4}, Lorg/simpleframework/xml/core/Expression;->isPath()Z

    move-result v5

    if-nez v5, :cond_2

    .line 130
    iget-object v5, p0, Lorg/simpleframework/xml/core/ModelAssembler;->format:Lorg/simpleframework/xml/stream/Format;

    invoke-virtual {v5}, Lorg/simpleframework/xml/stream/Format;->getStyle()Lorg/simpleframework/xml/stream/Style;

    move-result-object v5

    .line 131
    .local v5, "style":Lorg/simpleframework/xml/stream/Style;
    invoke-interface {v5, v3}, Lorg/simpleframework/xml/stream/Style;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 133
    .local v6, "name":Ljava/lang/String;
    invoke-interface {p1, v6}, Lorg/simpleframework/xml/core/Model;->registerAttribute(Ljava/lang/String;)V

    .line 134
    .end local v5    # "style":Lorg/simpleframework/xml/stream/Style;
    .end local v6    # "name":Ljava/lang/String;
    goto :goto_2

    .line 135
    :cond_2
    invoke-direct {p0, p1, v4}, Lorg/simpleframework/xml/core/ModelAssembler;->registerAttributes(Lorg/simpleframework/xml/core/Model;Lorg/simpleframework/xml/core/Expression;)V

    .line 123
    .end local v3    # "value":Ljava/lang/String;
    .end local v4    # "path":Lorg/simpleframework/xml/core/Expression;
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 138
    :cond_3
    return-void
.end method

.method private assembleElements(Lorg/simpleframework/xml/core/Model;Lorg/simpleframework/xml/Order;)V
    .locals 6
    .param p1, "model"    # Lorg/simpleframework/xml/core/Model;
    .param p2, "order"    # Lorg/simpleframework/xml/Order;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 103
    invoke-interface {p2}, Lorg/simpleframework/xml/Order;->elements()[Ljava/lang/String;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    .line 104
    .local v3, "value":Ljava/lang/String;
    iget-object v4, p0, Lorg/simpleframework/xml/core/ModelAssembler;->builder:Lorg/simpleframework/xml/core/ExpressionBuilder;

    invoke-virtual {v4, v3}, Lorg/simpleframework/xml/core/ExpressionBuilder;->build(Ljava/lang/String;)Lorg/simpleframework/xml/core/Expression;

    move-result-object v4

    .line 106
    .local v4, "path":Lorg/simpleframework/xml/core/Expression;
    invoke-interface {v4}, Lorg/simpleframework/xml/core/Expression;->isAttribute()Z

    move-result v5

    if-nez v5, :cond_0

    .line 109
    invoke-direct {p0, p1, v4}, Lorg/simpleframework/xml/core/ModelAssembler;->registerElements(Lorg/simpleframework/xml/core/Model;Lorg/simpleframework/xml/core/Expression;)V

    .line 103
    .end local v3    # "value":Ljava/lang/String;
    .end local v4    # "path":Lorg/simpleframework/xml/core/Expression;
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 107
    .restart local v3    # "value":Ljava/lang/String;
    .restart local v4    # "path":Lorg/simpleframework/xml/core/Expression;
    :cond_0
    new-instance v0, Lorg/simpleframework/xml/core/PathException;

    iget-object v1, p0, Lorg/simpleframework/xml/core/ModelAssembler;->detail:Lorg/simpleframework/xml/core/Detail;

    filled-new-array {v4, v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "Ordered element \'%s\' references an attribute in %s"

    invoke-direct {v0, v2, v1}, Lorg/simpleframework/xml/core/PathException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v0

    .line 111
    .end local v3    # "value":Ljava/lang/String;
    .end local v4    # "path":Lorg/simpleframework/xml/core/Expression;
    :cond_1
    return-void
.end method

.method private registerAttribute(Lorg/simpleframework/xml/core/Model;Lorg/simpleframework/xml/core/Expression;)V
    .locals 1
    .param p1, "model"    # Lorg/simpleframework/xml/core/Model;
    .param p2, "path"    # Lorg/simpleframework/xml/core/Expression;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 176
    invoke-interface {p2}, Lorg/simpleframework/xml/core/Expression;->getFirst()Ljava/lang/String;

    move-result-object v0

    .line 178
    .local v0, "name":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 179
    invoke-interface {p1, v0}, Lorg/simpleframework/xml/core/Model;->registerAttribute(Ljava/lang/String;)V

    .line 181
    :cond_0
    return-void
.end method

.method private registerAttributes(Lorg/simpleframework/xml/core/Model;Lorg/simpleframework/xml/core/Expression;)V
    .locals 8
    .param p1, "model"    # Lorg/simpleframework/xml/core/Model;
    .param p2, "path"    # Lorg/simpleframework/xml/core/Expression;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 149
    invoke-interface {p2}, Lorg/simpleframework/xml/core/Expression;->getPrefix()Ljava/lang/String;

    move-result-object v0

    .line 150
    .local v0, "prefix":Ljava/lang/String;
    invoke-interface {p2}, Lorg/simpleframework/xml/core/Expression;->getFirst()Ljava/lang/String;

    move-result-object v1

    .line 151
    .local v1, "name":Ljava/lang/String;
    invoke-interface {p2}, Lorg/simpleframework/xml/core/Expression;->getIndex()I

    move-result v2

    .line 153
    .local v2, "index":I
    invoke-interface {p2}, Lorg/simpleframework/xml/core/Expression;->isPath()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 154
    invoke-interface {p1, v1, v0, v2}, Lorg/simpleframework/xml/core/Model;->register(Ljava/lang/String;Ljava/lang/String;I)Lorg/simpleframework/xml/core/Model;

    move-result-object v3

    .line 155
    .local v3, "next":Lorg/simpleframework/xml/core/Model;
    const/4 v4, 0x1

    invoke-interface {p2, v4}, Lorg/simpleframework/xml/core/Expression;->getPath(I)Lorg/simpleframework/xml/core/Expression;

    move-result-object v4

    .line 157
    .local v4, "child":Lorg/simpleframework/xml/core/Expression;
    if-eqz v3, :cond_0

    .line 160
    invoke-direct {p0, v3, v4}, Lorg/simpleframework/xml/core/ModelAssembler;->registerAttributes(Lorg/simpleframework/xml/core/Model;Lorg/simpleframework/xml/core/Expression;)V

    .line 161
    .end local v3    # "next":Lorg/simpleframework/xml/core/Model;
    .end local v4    # "child":Lorg/simpleframework/xml/core/Expression;
    goto :goto_0

    .line 158
    .restart local v3    # "next":Lorg/simpleframework/xml/core/Model;
    .restart local v4    # "child":Lorg/simpleframework/xml/core/Expression;
    :cond_0
    new-instance v5, Lorg/simpleframework/xml/core/PathException;

    iget-object v6, p0, Lorg/simpleframework/xml/core/ModelAssembler;->detail:Lorg/simpleframework/xml/core/Detail;

    filled-new-array {v1, v6}, [Ljava/lang/Object;

    move-result-object v6

    const-string v7, "Element \'%s\' does not exist in %s"

    invoke-direct {v5, v7, v6}, Lorg/simpleframework/xml/core/PathException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v5

    .line 162
    .end local v3    # "next":Lorg/simpleframework/xml/core/Model;
    .end local v4    # "child":Lorg/simpleframework/xml/core/Expression;
    :cond_1
    invoke-direct {p0, p1, p2}, Lorg/simpleframework/xml/core/ModelAssembler;->registerAttribute(Lorg/simpleframework/xml/core/Model;Lorg/simpleframework/xml/core/Expression;)V

    .line 164
    :goto_0
    return-void
.end method

.method private registerElement(Lorg/simpleframework/xml/core/Model;Lorg/simpleframework/xml/core/Expression;)V
    .locals 7
    .param p1, "model"    # Lorg/simpleframework/xml/core/Model;
    .param p2, "path"    # Lorg/simpleframework/xml/core/Expression;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 228
    invoke-interface {p2}, Lorg/simpleframework/xml/core/Expression;->getPrefix()Ljava/lang/String;

    move-result-object v0

    .line 229
    .local v0, "prefix":Ljava/lang/String;
    invoke-interface {p2}, Lorg/simpleframework/xml/core/Expression;->getFirst()Ljava/lang/String;

    move-result-object v1

    .line 230
    .local v1, "name":Ljava/lang/String;
    invoke-interface {p2}, Lorg/simpleframework/xml/core/Expression;->getIndex()I

    move-result v2

    .line 232
    .local v2, "index":I
    const/4 v3, 0x1

    if-le v2, v3, :cond_1

    .line 233
    add-int/lit8 v3, v2, -0x1

    invoke-interface {p1, v1, v3}, Lorg/simpleframework/xml/core/Model;->lookup(Ljava/lang/String;I)Lorg/simpleframework/xml/core/Model;

    move-result-object v3

    .line 235
    .local v3, "previous":Lorg/simpleframework/xml/core/Model;
    if-eqz v3, :cond_0

    goto :goto_0

    .line 236
    :cond_0
    new-instance v4, Lorg/simpleframework/xml/core/PathException;

    iget-object v5, p0, Lorg/simpleframework/xml/core/ModelAssembler;->detail:Lorg/simpleframework/xml/core/Detail;

    filled-new-array {v1, p2, v5}, [Ljava/lang/Object;

    move-result-object v5

    const-string v6, "Ordered element \'%s\' in path \'%s\' is out of sequence for %s"

    invoke-direct {v4, v6, v5}, Lorg/simpleframework/xml/core/PathException;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V

    throw v4

    .line 239
    .end local v3    # "previous":Lorg/simpleframework/xml/core/Model;
    :cond_1
    :goto_0
    invoke-interface {p1, v1, v0, v2}, Lorg/simpleframework/xml/core/Model;->register(Ljava/lang/String;Ljava/lang/String;I)Lorg/simpleframework/xml/core/Model;

    .line 240
    return-void
.end method

.method private registerElements(Lorg/simpleframework/xml/core/Model;Lorg/simpleframework/xml/core/Expression;)V
    .locals 6
    .param p1, "model"    # Lorg/simpleframework/xml/core/Model;
    .param p2, "path"    # Lorg/simpleframework/xml/core/Expression;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 192
    invoke-interface {p2}, Lorg/simpleframework/xml/core/Expression;->getPrefix()Ljava/lang/String;

    move-result-object v0

    .line 193
    .local v0, "prefix":Ljava/lang/String;
    invoke-interface {p2}, Lorg/simpleframework/xml/core/Expression;->getFirst()Ljava/lang/String;

    move-result-object v1

    .line 194
    .local v1, "name":Ljava/lang/String;
    invoke-interface {p2}, Lorg/simpleframework/xml/core/Expression;->getIndex()I

    move-result v2

    .line 196
    .local v2, "index":I
    if-eqz v1, :cond_0

    .line 197
    invoke-interface {p1, v1, v0, v2}, Lorg/simpleframework/xml/core/Model;->register(Ljava/lang/String;Ljava/lang/String;I)Lorg/simpleframework/xml/core/Model;

    move-result-object v3

    .line 198
    .local v3, "next":Lorg/simpleframework/xml/core/Model;
    const/4 v4, 0x1

    invoke-interface {p2, v4}, Lorg/simpleframework/xml/core/Expression;->getPath(I)Lorg/simpleframework/xml/core/Expression;

    move-result-object v4

    .line 200
    .local v4, "child":Lorg/simpleframework/xml/core/Expression;
    invoke-interface {p2}, Lorg/simpleframework/xml/core/Expression;->isPath()Z

    move-result v5

    if-eqz v5, :cond_0

    .line 201
    invoke-direct {p0, v3, v4}, Lorg/simpleframework/xml/core/ModelAssembler;->registerElements(Lorg/simpleframework/xml/core/Model;Lorg/simpleframework/xml/core/Expression;)V

    .line 204
    .end local v3    # "next":Lorg/simpleframework/xml/core/Model;
    .end local v4    # "child":Lorg/simpleframework/xml/core/Expression;
    :cond_0
    invoke-direct {p0, p1, p2}, Lorg/simpleframework/xml/core/ModelAssembler;->registerElement(Lorg/simpleframework/xml/core/Model;Lorg/simpleframework/xml/core/Expression;)V

    .line 205
    return-void
.end method


# virtual methods
.method public assemble(Lorg/simpleframework/xml/core/Model;Lorg/simpleframework/xml/Order;)V
    .locals 0
    .param p1, "model"    # Lorg/simpleframework/xml/core/Model;
    .param p2, "order"    # Lorg/simpleframework/xml/Order;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 89
    invoke-direct {p0, p1, p2}, Lorg/simpleframework/xml/core/ModelAssembler;->assembleElements(Lorg/simpleframework/xml/core/Model;Lorg/simpleframework/xml/Order;)V

    .line 90
    invoke-direct {p0, p1, p2}, Lorg/simpleframework/xml/core/ModelAssembler;->assembleAttributes(Lorg/simpleframework/xml/core/Model;Lorg/simpleframework/xml/Order;)V

    .line 91
    return-void
.end method
