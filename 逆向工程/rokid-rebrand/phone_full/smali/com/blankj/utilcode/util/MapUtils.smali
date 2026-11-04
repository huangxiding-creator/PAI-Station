.class public Lcom/blankj/utilcode/util/MapUtils;
.super Ljava/lang/Object;
.source "MapUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/blankj/utilcode/util/MapUtils$Transformer;,
        Lcom/blankj/utilcode/util/MapUtils$Closure;
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string/jumbo v1, "u can\'t instantiate me..."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static forAllDo(Ljava/util/Map;Lcom/blankj/utilcode/util/MapUtils$Closure;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<K:",
            "Ljava/lang/Object;",
            "V:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/util/Map<",
            "TK;TV;>;",
            "Lcom/blankj/utilcode/util/MapUtils$Closure<",
            "TK;TV;>;)V"
        }
    .end annotation

    .line 139
    .local p0, "map":Ljava/util/Map;, "Ljava/util/Map<TK;TV;>;"
    .local p1, "closure":Lcom/blankj/utilcode/util/MapUtils$Closure;, "Lcom/blankj/utilcode/util/MapUtils$Closure<TK;TV;>;"
    if-eqz p0, :cond_2

    if-nez p1, :cond_0

    goto :goto_1

    .line 140
    :cond_0
    invoke-interface {p0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 141
    .local v1, "kvEntry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<TK;TV;>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    invoke-interface {p1, v2, v3}, Lcom/blankj/utilcode/util/MapUtils$Closure;->execute(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 142
    .end local v1    # "kvEntry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<TK;TV;>;"
    goto :goto_0

    .line 143
    :cond_1
    return-void

    .line 139
    :cond_2
    :goto_1
    return-void
.end method

.method public static isEmpty(Ljava/util/Map;)Z
    .locals 1
    .param p0, "map"    # Ljava/util/Map;

    .line 104
    if-eqz p0, :cond_1

    invoke-interface {p0}, Ljava/util/Map;->size()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    return v0
.end method

.method public static isNotEmpty(Ljava/util/Map;)Z
    .locals 1
    .param p0, "map"    # Ljava/util/Map;

    .line 116
    invoke-static {p0}, Lcom/blankj/utilcode/util/MapUtils;->isEmpty(Ljava/util/Map;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public static varargs newHashMap([Landroid/util/Pair;)Ljava/util/HashMap;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<K:",
            "Ljava/lang/Object;",
            "V:",
            "Ljava/lang/Object;",
            ">([",
            "Landroid/util/Pair<",
            "TK;TV;>;)",
            "Ljava/util/HashMap<",
            "TK;TV;>;"
        }
    .end annotation

    .annotation runtime Ljava/lang/SafeVarargs;
    .end annotation

    .line 41
    .local p0, "pairs":[Landroid/util/Pair;, "[Landroid/util/Pair<TK;TV;>;"
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 42
    .local v0, "map":Ljava/util/HashMap;, "Ljava/util/HashMap<TK;TV;>;"
    if-eqz p0, :cond_3

    array-length v1, p0

    if-nez v1, :cond_0

    goto :goto_2

    .line 45
    :cond_0
    array-length v1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_2

    aget-object v3, p0, v2

    .line 46
    .local v3, "pair":Landroid/util/Pair;, "Landroid/util/Pair<TK;TV;>;"
    if-nez v3, :cond_1

    goto :goto_1

    .line 47
    :cond_1
    iget-object v4, v3, Landroid/util/Pair;->first:Ljava/lang/Object;

    iget-object v5, v3, Landroid/util/Pair;->second:Ljava/lang/Object;

    invoke-virtual {v0, v4, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 45
    .end local v3    # "pair":Landroid/util/Pair;, "Landroid/util/Pair<TK;TV;>;"
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 49
    :cond_2
    return-object v0

    .line 43
    :cond_3
    :goto_2
    return-object v0
.end method

.method public static varargs newHashTable([Landroid/util/Pair;)Ljava/util/Hashtable;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<K:",
            "Ljava/lang/Object;",
            "V:",
            "Ljava/lang/Object;",
            ">([",
            "Landroid/util/Pair<",
            "TK;TV;>;)",
            "Ljava/util/Hashtable<",
            "TK;TV;>;"
        }
    .end annotation

    .annotation runtime Ljava/lang/SafeVarargs;
    .end annotation

    .line 84
    .local p0, "pairs":[Landroid/util/Pair;, "[Landroid/util/Pair<TK;TV;>;"
    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    .line 85
    .local v0, "map":Ljava/util/Hashtable;, "Ljava/util/Hashtable<TK;TV;>;"
    if-eqz p0, :cond_3

    array-length v1, p0

    if-nez v1, :cond_0

    goto :goto_2

    .line 88
    :cond_0
    array-length v1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_2

    aget-object v3, p0, v2

    .line 89
    .local v3, "pair":Landroid/util/Pair;, "Landroid/util/Pair<TK;TV;>;"
    if-nez v3, :cond_1

    goto :goto_1

    .line 90
    :cond_1
    iget-object v4, v3, Landroid/util/Pair;->first:Ljava/lang/Object;

    iget-object v5, v3, Landroid/util/Pair;->second:Ljava/lang/Object;

    invoke-virtual {v0, v4, v5}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 88
    .end local v3    # "pair":Landroid/util/Pair;, "Landroid/util/Pair<TK;TV;>;"
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 92
    :cond_2
    return-object v0

    .line 86
    :cond_3
    :goto_2
    return-object v0
.end method

.method public static varargs newLinkedHashMap([Landroid/util/Pair;)Ljava/util/LinkedHashMap;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<K:",
            "Ljava/lang/Object;",
            "V:",
            "Ljava/lang/Object;",
            ">([",
            "Landroid/util/Pair<",
            "TK;TV;>;)",
            "Ljava/util/LinkedHashMap<",
            "TK;TV;>;"
        }
    .end annotation

    .annotation runtime Ljava/lang/SafeVarargs;
    .end annotation

    .line 54
    .local p0, "pairs":[Landroid/util/Pair;, "[Landroid/util/Pair<TK;TV;>;"
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    .line 55
    .local v0, "map":Ljava/util/LinkedHashMap;, "Ljava/util/LinkedHashMap<TK;TV;>;"
    if-eqz p0, :cond_3

    array-length v1, p0

    if-nez v1, :cond_0

    goto :goto_2

    .line 58
    :cond_0
    array-length v1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_2

    aget-object v3, p0, v2

    .line 59
    .local v3, "pair":Landroid/util/Pair;, "Landroid/util/Pair<TK;TV;>;"
    if-nez v3, :cond_1

    goto :goto_1

    .line 60
    :cond_1
    iget-object v4, v3, Landroid/util/Pair;->first:Ljava/lang/Object;

    iget-object v5, v3, Landroid/util/Pair;->second:Ljava/lang/Object;

    invoke-virtual {v0, v4, v5}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 58
    .end local v3    # "pair":Landroid/util/Pair;, "Landroid/util/Pair<TK;TV;>;"
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 62
    :cond_2
    return-object v0

    .line 56
    :cond_3
    :goto_2
    return-object v0
.end method

.method public static varargs newTreeMap(Ljava/util/Comparator;[Landroid/util/Pair;)Ljava/util/TreeMap;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<K:",
            "Ljava/lang/Object;",
            "V:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/util/Comparator<",
            "TK;>;[",
            "Landroid/util/Pair<",
            "TK;TV;>;)",
            "Ljava/util/TreeMap<",
            "TK;TV;>;"
        }
    .end annotation

    .annotation runtime Ljava/lang/SafeVarargs;
    .end annotation

    .line 68
    .local p0, "comparator":Ljava/util/Comparator;, "Ljava/util/Comparator<TK;>;"
    .local p1, "pairs":[Landroid/util/Pair;, "[Landroid/util/Pair<TK;TV;>;"
    if-eqz p0, :cond_4

    .line 71
    new-instance v0, Ljava/util/TreeMap;

    invoke-direct {v0, p0}, Ljava/util/TreeMap;-><init>(Ljava/util/Comparator;)V

    .line 72
    .local v0, "map":Ljava/util/TreeMap;, "Ljava/util/TreeMap<TK;TV;>;"
    if-eqz p1, :cond_3

    array-length v1, p1

    if-nez v1, :cond_0

    goto :goto_2

    .line 75
    :cond_0
    array-length v1, p1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_2

    aget-object v3, p1, v2

    .line 76
    .local v3, "pair":Landroid/util/Pair;, "Landroid/util/Pair<TK;TV;>;"
    if-nez v3, :cond_1

    goto :goto_1

    .line 77
    :cond_1
    iget-object v4, v3, Landroid/util/Pair;->first:Ljava/lang/Object;

    iget-object v5, v3, Landroid/util/Pair;->second:Ljava/lang/Object;

    invoke-virtual {v0, v4, v5}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 75
    .end local v3    # "pair":Landroid/util/Pair;, "Landroid/util/Pair<TK;TV;>;"
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 79
    :cond_2
    return-object v0

    .line 73
    :cond_3
    :goto_2
    return-object v0

    .line 69
    .end local v0    # "map":Ljava/util/TreeMap;, "Ljava/util/TreeMap<TK;TV;>;"
    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "comparator must not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static varargs newUnmodifiableMap([Landroid/util/Pair;)Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<K:",
            "Ljava/lang/Object;",
            "V:",
            "Ljava/lang/Object;",
            ">([",
            "Landroid/util/Pair<",
            "TK;TV;>;)",
            "Ljava/util/Map<",
            "TK;TV;>;"
        }
    .end annotation

    .annotation runtime Ljava/lang/SafeVarargs;
    .end annotation

    .line 36
    .local p0, "pairs":[Landroid/util/Pair;, "[Landroid/util/Pair<TK;TV;>;"
    invoke-static {p0}, Lcom/blankj/utilcode/util/MapUtils;->newHashMap([Landroid/util/Pair;)Ljava/util/HashMap;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public static size(Ljava/util/Map;)I
    .locals 1
    .param p0, "map"    # Ljava/util/Map;

    .line 126
    if-nez p0, :cond_0

    const/4 v0, 0x0

    return v0

    .line 127
    :cond_0
    invoke-interface {p0}, Ljava/util/Map;->size()I

    move-result v0

    return v0
.end method

.method public static toString(Ljava/util/Map;)Ljava/lang/String;
    .locals 1
    .param p0, "map"    # Ljava/util/Map;

    .line 180
    if-nez p0, :cond_0

    const-string v0, "null"

    return-object v0

    .line 181
    :cond_0
    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static transform(Ljava/util/Map;Lcom/blankj/utilcode/util/MapUtils$Transformer;)Ljava/util/Map;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<K1:",
            "Ljava/lang/Object;",
            "V1:",
            "Ljava/lang/Object;",
            "K2:",
            "Ljava/lang/Object;",
            "V2:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/util/Map<",
            "TK1;TV1;>;",
            "Lcom/blankj/utilcode/util/MapUtils$Transformer<",
            "TK1;TV1;TK2;TV2;>;)",
            "Ljava/util/Map<",
            "TK2;TV2;>;"
        }
    .end annotation

    .line 154
    .local p0, "map":Ljava/util/Map;, "Ljava/util/Map<TK1;TV1;>;"
    .local p1, "transformer":Lcom/blankj/utilcode/util/MapUtils$Transformer;, "Lcom/blankj/utilcode/util/MapUtils$Transformer<TK1;TV1;TK2;TV2;>;"
    const/4 v0, 0x0

    if-eqz p0, :cond_1

    if-nez p1, :cond_0

    goto :goto_1

    .line 156
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map;

    .line 157
    .local v1, "transMap":Ljava/util/Map;, "Ljava/util/Map<TK2;TV2;>;"
    new-instance v2, Lcom/blankj/utilcode/util/MapUtils$1;

    invoke-direct {v2, p1, v1}, Lcom/blankj/utilcode/util/MapUtils$1;-><init>(Lcom/blankj/utilcode/util/MapUtils$Transformer;Ljava/util/Map;)V

    invoke-static {p0, v2}, Lcom/blankj/utilcode/util/MapUtils;->forAllDo(Ljava/util/Map;Lcom/blankj/utilcode/util/MapUtils$Closure;)V
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_0

    .line 164
    return-object v1

    .line 167
    .end local v1    # "transMap":Ljava/util/Map;, "Ljava/util/Map<TK2;TV2;>;"
    :catch_0
    move-exception v1

    .line 168
    .local v1, "e":Ljava/lang/InstantiationException;
    invoke-virtual {v1}, Ljava/lang/InstantiationException;->printStackTrace()V

    goto :goto_0

    .line 165
    .end local v1    # "e":Ljava/lang/InstantiationException;
    :catch_1
    move-exception v1

    .line 166
    .local v1, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v1}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    .line 169
    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    nop

    .line 170
    :goto_0
    return-object v0

    .line 154
    :cond_1
    :goto_1
    return-object v0
.end method
