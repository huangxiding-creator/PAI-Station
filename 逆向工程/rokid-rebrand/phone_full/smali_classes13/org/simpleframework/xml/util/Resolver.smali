.class public Lorg/simpleframework/xml/util/Resolver;
.super Ljava/util/AbstractSet;
.source "Resolver.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/simpleframework/xml/util/Resolver$Stack;,
        Lorg/simpleframework/xml/util/Resolver$Cache;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<M::",
        "Lorg/simpleframework/xml/util/Match;",
        ">",
        "Ljava/util/AbstractSet<",
        "TM;>;"
    }
.end annotation


# instance fields
.field protected final cache:Lorg/simpleframework/xml/util/Resolver$Cache;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lorg/simpleframework/xml/util/Resolver<",
            "TM;>.Cache;"
        }
    .end annotation
.end field

.field protected final stack:Lorg/simpleframework/xml/util/Resolver$Stack;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lorg/simpleframework/xml/util/Resolver<",
            "TM;>.Stack;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 82
    .local p0, "this":Lorg/simpleframework/xml/util/Resolver;, "Lorg/simpleframework/xml/util/Resolver<TM;>;"
    invoke-direct {p0}, Ljava/util/AbstractSet;-><init>()V

    .line 83
    new-instance v0, Lorg/simpleframework/xml/util/Resolver$Stack;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lorg/simpleframework/xml/util/Resolver$Stack;-><init>(Lorg/simpleframework/xml/util/Resolver;Lorg/simpleframework/xml/util/Resolver$1;)V

    iput-object v0, p0, Lorg/simpleframework/xml/util/Resolver;->stack:Lorg/simpleframework/xml/util/Resolver$Stack;

    .line 84
    new-instance v0, Lorg/simpleframework/xml/util/Resolver$Cache;

    invoke-direct {v0, p0}, Lorg/simpleframework/xml/util/Resolver$Cache;-><init>(Lorg/simpleframework/xml/util/Resolver;)V

    iput-object v0, p0, Lorg/simpleframework/xml/util/Resolver;->cache:Lorg/simpleframework/xml/util/Resolver$Cache;

    .line 85
    return-void
.end method

.method private match([CI[CI)Z
    .locals 5
    .param p1, "text"    # [C
    .param p2, "off"    # I
    .param p3, "wild"    # [C
    .param p4, "pos"    # I

    .line 251
    .local p0, "this":Lorg/simpleframework/xml/util/Resolver;, "Lorg/simpleframework/xml/util/Resolver<TM;>;"
    nop

    :goto_0
    array-length v0, p3

    const/16 v1, 0x2a

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-ge p4, v0, :cond_8

    array-length v0, p1

    if-ge p2, v0, :cond_8

    .line 252
    aget-char v0, p3, p4

    const/16 v4, 0x3f

    if-ne v0, v1, :cond_6

    .line 253
    :cond_0
    aget-char v0, p3, p4

    if-ne v0, v1, :cond_1

    .line 254
    add-int/lit8 p4, p4, 0x1

    array-length v0, p3

    if-lt p4, v0, :cond_0

    .line 255
    return v3

    .line 257
    :cond_1
    aget-char v0, p3, p4

    if-ne v0, v4, :cond_2

    .line 258
    add-int/lit8 p4, p4, 0x1

    array-length v0, p3

    if-lt p4, v0, :cond_2

    .line 259
    return v3

    .line 261
    :cond_2
    :goto_1
    array-length v0, p1

    if-ge p2, v0, :cond_5

    .line 262
    aget-char v0, p1, p2

    aget-char v1, p3, p4

    if-eq v0, v1, :cond_3

    aget-char v0, p3, p4

    if-ne v0, v4, :cond_4

    .line 263
    :cond_3
    add-int/lit8 v0, p4, -0x1

    aget-char v0, p3, v0

    if-eq v0, v4, :cond_5

    .line 264
    invoke-direct {p0, p1, p2, p3, p4}, Lorg/simpleframework/xml/util/Resolver;->match([CI[CI)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 265
    return v3

    .line 261
    :cond_4
    add-int/lit8 p2, p2, 0x1

    goto :goto_1

    .line 271
    :cond_5
    array-length v0, p1

    if-ne v0, p2, :cond_6

    .line 272
    return v2

    .line 274
    :cond_6
    add-int/lit8 v0, p2, 0x1

    .end local p2    # "off":I
    .local v0, "off":I
    aget-char p2, p1, p2

    add-int/lit8 v1, p4, 0x1

    .end local p4    # "pos":I
    .local v1, "pos":I
    aget-char p4, p3, p4

    if-eq p2, p4, :cond_7

    .line 275
    add-int/lit8 p2, v1, -0x1

    aget-char p2, p3, p2

    if-eq p2, v4, :cond_7

    .line 276
    return v2

    .line 251
    :cond_7
    move p2, v0

    move p4, v1

    goto :goto_0

    .line 279
    .end local v0    # "off":I
    .end local v1    # "pos":I
    .restart local p2    # "off":I
    .restart local p4    # "pos":I
    :cond_8
    array-length v0, p3

    if-ne v0, p4, :cond_a

    .line 280
    array-length v0, p1

    if-ne v0, p2, :cond_9

    move v2, v3

    :cond_9
    return v2

    .line 282
    :cond_a
    aget-char v0, p3, p4

    if-ne v0, v1, :cond_b

    .line 283
    add-int/lit8 p4, p4, 0x1

    array-length v0, p3

    if-lt p4, v0, :cond_a

    .line 284
    return v3

    .line 286
    :cond_b
    return v2
.end method

.method private match([C[C)Z
    .locals 1
    .param p1, "text"    # [C
    .param p2, "wild"    # [C

    .line 235
    .local p0, "this":Lorg/simpleframework/xml/util/Resolver;, "Lorg/simpleframework/xml/util/Resolver<TM;>;"
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0, p2, v0}, Lorg/simpleframework/xml/util/Resolver;->match([CI[CI)Z

    move-result v0

    return v0
.end method

.method private resolveAll(Ljava/lang/String;[C)Ljava/util/List;
    .locals 5
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "array"    # [C
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "[C)",
            "Ljava/util/List<",
            "TM;>;"
        }
    .end annotation

    .line 148
    .local p0, "this":Lorg/simpleframework/xml/util/Resolver;, "Lorg/simpleframework/xml/util/Resolver<TM;>;"
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 150
    .local v0, "list":Ljava/util/List;, "Ljava/util/List<TM;>;"
    iget-object v1, p0, Lorg/simpleframework/xml/util/Resolver;->stack:Lorg/simpleframework/xml/util/Resolver$Stack;

    invoke-virtual {v1}, Lorg/simpleframework/xml/util/Resolver$Stack;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/simpleframework/xml/util/Match;

    .line 151
    .local v2, "match":Lorg/simpleframework/xml/util/Match;, "TM;"
    invoke-interface {v2}, Lorg/simpleframework/xml/util/Match;->getPattern()Ljava/lang/String;

    move-result-object v3

    .line 153
    .local v3, "wild":Ljava/lang/String;
    invoke-virtual {v3}, Ljava/lang/String;->toCharArray()[C

    move-result-object v4

    invoke-direct {p0, p2, v4}, Lorg/simpleframework/xml/util/Resolver;->match([C[C)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 154
    iget-object v4, p0, Lorg/simpleframework/xml/util/Resolver;->cache:Lorg/simpleframework/xml/util/Resolver$Cache;

    invoke-virtual {v4, p1, v0}, Lorg/simpleframework/xml/util/Resolver$Cache;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 155
    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 157
    .end local v2    # "match":Lorg/simpleframework/xml/util/Match;, "TM;"
    .end local v3    # "wild":Ljava/lang/String;
    :cond_0
    goto :goto_0

    .line 158
    :cond_1
    return-object v0
.end method


# virtual methods
.method public bridge synthetic add(Ljava/lang/Object;)Z
    .locals 0

    .line 62
    .local p0, "this":Lorg/simpleframework/xml/util/Resolver;, "Lorg/simpleframework/xml/util/Resolver<TM;>;"
    check-cast p1, Lorg/simpleframework/xml/util/Match;

    invoke-virtual {p0, p1}, Lorg/simpleframework/xml/util/Resolver;->add(Lorg/simpleframework/xml/util/Match;)Z

    move-result p1

    return p1
.end method

.method public add(Lorg/simpleframework/xml/util/Match;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TM;)Z"
        }
    .end annotation

    .line 172
    .local p0, "this":Lorg/simpleframework/xml/util/Resolver;, "Lorg/simpleframework/xml/util/Resolver<TM;>;"
    .local p1, "match":Lorg/simpleframework/xml/util/Match;, "TM;"
    iget-object v0, p0, Lorg/simpleframework/xml/util/Resolver;->stack:Lorg/simpleframework/xml/util/Resolver$Stack;

    invoke-virtual {v0, p1}, Lorg/simpleframework/xml/util/Resolver$Stack;->push(Lorg/simpleframework/xml/util/Match;)V

    .line 173
    const/4 v0, 0x1

    return v0
.end method

.method public clear()V
    .locals 1

    .line 221
    .local p0, "this":Lorg/simpleframework/xml/util/Resolver;, "Lorg/simpleframework/xml/util/Resolver<TM;>;"
    iget-object v0, p0, Lorg/simpleframework/xml/util/Resolver;->cache:Lorg/simpleframework/xml/util/Resolver$Cache;

    invoke-virtual {v0}, Lorg/simpleframework/xml/util/Resolver$Cache;->clear()V

    .line 222
    iget-object v0, p0, Lorg/simpleframework/xml/util/Resolver;->stack:Lorg/simpleframework/xml/util/Resolver$Stack;

    invoke-virtual {v0}, Lorg/simpleframework/xml/util/Resolver$Stack;->clear()V

    .line 223
    return-void
.end method

.method public iterator()Ljava/util/Iterator;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Iterator<",
            "TM;>;"
        }
    .end annotation

    .line 185
    .local p0, "this":Lorg/simpleframework/xml/util/Resolver;, "Lorg/simpleframework/xml/util/Resolver<TM;>;"
    iget-object v0, p0, Lorg/simpleframework/xml/util/Resolver;->stack:Lorg/simpleframework/xml/util/Resolver$Stack;

    invoke-virtual {v0}, Lorg/simpleframework/xml/util/Resolver$Stack;->sequence()Ljava/util/Iterator;

    move-result-object v0

    return-object v0
.end method

.method public remove(Lorg/simpleframework/xml/util/Match;)Z
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TM;)Z"
        }
    .end annotation

    .line 199
    .local p0, "this":Lorg/simpleframework/xml/util/Resolver;, "Lorg/simpleframework/xml/util/Resolver<TM;>;"
    .local p1, "match":Lorg/simpleframework/xml/util/Match;, "TM;"
    iget-object v0, p0, Lorg/simpleframework/xml/util/Resolver;->cache:Lorg/simpleframework/xml/util/Resolver$Cache;

    invoke-virtual {v0}, Lorg/simpleframework/xml/util/Resolver$Cache;->clear()V

    .line 200
    iget-object v0, p0, Lorg/simpleframework/xml/util/Resolver;->stack:Lorg/simpleframework/xml/util/Resolver$Stack;

    invoke-virtual {v0, p1}, Lorg/simpleframework/xml/util/Resolver$Stack;->remove(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public resolve(Ljava/lang/String;)Lorg/simpleframework/xml/util/Match;
    .locals 2
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")TM;"
        }
    .end annotation

    .line 99
    .local p0, "this":Lorg/simpleframework/xml/util/Resolver;, "Lorg/simpleframework/xml/util/Resolver<TM;>;"
    iget-object v0, p0, Lorg/simpleframework/xml/util/Resolver;->cache:Lorg/simpleframework/xml/util/Resolver$Cache;

    invoke-virtual {v0, p1}, Lorg/simpleframework/xml/util/Resolver$Cache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 101
    .local v0, "list":Ljava/util/List;, "Ljava/util/List<TM;>;"
    if-nez v0, :cond_0

    .line 102
    invoke-virtual {p0, p1}, Lorg/simpleframework/xml/util/Resolver;->resolveAll(Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    .line 104
    :cond_0
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 105
    const/4 v1, 0x0

    return-object v1

    .line 107
    :cond_1
    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/simpleframework/xml/util/Match;

    return-object v1
.end method

.method public resolveAll(Ljava/lang/String;)Ljava/util/List;
    .locals 3
    .param p1, "text"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "TM;>;"
        }
    .end annotation

    .line 122
    .local p0, "this":Lorg/simpleframework/xml/util/Resolver;, "Lorg/simpleframework/xml/util/Resolver<TM;>;"
    iget-object v0, p0, Lorg/simpleframework/xml/util/Resolver;->cache:Lorg/simpleframework/xml/util/Resolver$Cache;

    invoke-virtual {v0, p1}, Lorg/simpleframework/xml/util/Resolver$Cache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    .line 124
    .local v0, "list":Ljava/util/List;, "Ljava/util/List<TM;>;"
    if-eqz v0, :cond_0

    .line 125
    return-object v0

    .line 127
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 129
    .local v1, "array":[C
    if-nez v1, :cond_1

    .line 130
    const/4 v2, 0x0

    return-object v2

    .line 132
    :cond_1
    invoke-direct {p0, p1, v1}, Lorg/simpleframework/xml/util/Resolver;->resolveAll(Ljava/lang/String;[C)Ljava/util/List;

    move-result-object v2

    return-object v2
.end method

.method public size()I
    .locals 1

    .line 211
    .local p0, "this":Lorg/simpleframework/xml/util/Resolver;, "Lorg/simpleframework/xml/util/Resolver<TM;>;"
    iget-object v0, p0, Lorg/simpleframework/xml/util/Resolver;->stack:Lorg/simpleframework/xml/util/Resolver$Stack;

    invoke-virtual {v0}, Lorg/simpleframework/xml/util/Resolver$Stack;->size()I

    move-result v0

    return v0
.end method
