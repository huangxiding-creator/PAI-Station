.class final Lcom/google/common/collect/JdkBackedImmutableBiMap;
.super Lcom/google/common/collect/ImmutableBiMap;
.source "JdkBackedImmutableBiMap.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/google/common/collect/JdkBackedImmutableBiMap$InverseEntries;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<K:",
        "Ljava/lang/Object;",
        "V:",
        "Ljava/lang/Object;",
        ">",
        "Lcom/google/common/collect/ImmutableBiMap<",
        "TK;TV;>;"
    }
.end annotation


# instance fields
.field private final backwardDelegate:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "TV;TK;>;"
        }
    .end annotation
.end field

.field private final transient entries:Lcom/google/common/collect/ImmutableList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/common/collect/ImmutableList<",
            "Ljava/util/Map$Entry<",
            "TK;TV;>;>;"
        }
    .end annotation
.end field

.field private final forwardDelegate:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "TK;TV;>;"
        }
    .end annotation
.end field

.field private transient inverse:Lcom/google/common/collect/JdkBackedImmutableBiMap;
    .annotation runtime Lcom/google/errorprone/annotations/concurrent/LazyInit;
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/common/collect/JdkBackedImmutableBiMap<",
            "TV;TK;>;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>(Lcom/google/common/collect/ImmutableList;Ljava/util/Map;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/common/collect/ImmutableList<",
            "Ljava/util/Map$Entry<",
            "TK;TV;>;>;",
            "Ljava/util/Map<",
            "TK;TV;>;",
            "Ljava/util/Map<",
            "TV;TK;>;)V"
        }
    .end annotation

    .line 57
    .local p0, "this":Lcom/google/common/collect/JdkBackedImmutableBiMap;, "Lcom/google/common/collect/JdkBackedImmutableBiMap<TK;TV;>;"
    .local p1, "entries":Lcom/google/common/collect/ImmutableList;, "Lcom/google/common/collect/ImmutableList<Ljava/util/Map$Entry<TK;TV;>;>;"
    .local p2, "forwardDelegate":Ljava/util/Map;, "Ljava/util/Map<TK;TV;>;"
    .local p3, "backwardDelegate":Ljava/util/Map;, "Ljava/util/Map<TV;TK;>;"
    invoke-direct {p0}, Lcom/google/common/collect/ImmutableBiMap;-><init>()V

    .line 58
    iput-object p1, p0, Lcom/google/common/collect/JdkBackedImmutableBiMap;->entries:Lcom/google/common/collect/ImmutableList;

    .line 59
    iput-object p2, p0, Lcom/google/common/collect/JdkBackedImmutableBiMap;->forwardDelegate:Ljava/util/Map;

    .line 60
    iput-object p3, p0, Lcom/google/common/collect/JdkBackedImmutableBiMap;->backwardDelegate:Ljava/util/Map;

    .line 61
    return-void
.end method

.method static synthetic access$100(Lcom/google/common/collect/JdkBackedImmutableBiMap;)Lcom/google/common/collect/ImmutableList;
    .locals 1
    .param p0, "x0"    # Lcom/google/common/collect/JdkBackedImmutableBiMap;

    .line 31
    iget-object v0, p0, Lcom/google/common/collect/JdkBackedImmutableBiMap;->entries:Lcom/google/common/collect/ImmutableList;

    return-object v0
.end method

.method static create(I[Ljava/util/Map$Entry;)Lcom/google/common/collect/ImmutableBiMap;
    .locals 11
    .param p0, "n"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<K:",
            "Ljava/lang/Object;",
            "V:",
            "Ljava/lang/Object;",
            ">(I[",
            "Ljava/util/Map$Entry<",
            "TK;TV;>;)",
            "Lcom/google/common/collect/ImmutableBiMap<",
            "TK;TV;>;"
        }
    .end annotation

    .line 34
    .local p1, "entryArray":[Ljava/util/Map$Entry;, "[Ljava/util/Map$Entry<TK;TV;>;"
    invoke-static {p0}, Lcom/google/common/collect/Maps;->newHashMapWithExpectedSize(I)Ljava/util/HashMap;

    move-result-object v0

    .line 35
    .local v0, "forwardDelegate":Ljava/util/Map;, "Ljava/util/Map<TK;TV;>;"
    invoke-static {p0}, Lcom/google/common/collect/Maps;->newHashMapWithExpectedSize(I)Ljava/util/HashMap;

    move-result-object v1

    .line 36
    .local v1, "backwardDelegate":Ljava/util/Map;, "Ljava/util/Map<TV;TK;>;"
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, p0, :cond_2

    .line 37
    aget-object v3, p1, v2

    invoke-static {v3}, Lcom/google/common/collect/RegularImmutableMap;->makeImmutable(Ljava/util/Map$Entry;)Lcom/google/common/collect/ImmutableMapEntry;

    move-result-object v3

    .line 38
    .local v3, "e":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<TK;TV;>;"
    aput-object v3, p1, v2

    .line 39
    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v5

    invoke-interface {v0, v4, v5}, Ljava/util/Map;->putIfAbsent(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 40
    .local v4, "oldValue":Ljava/lang/Object;, "TV;"
    const-string v5, "="

    if-nez v4, :cond_1

    .line 43
    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v6

    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v7

    invoke-interface {v1, v6, v7}, Ljava/util/Map;->putIfAbsent(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 44
    .local v6, "oldKey":Ljava/lang/Object;, "TK;"
    if-nez v6, :cond_0

    .line 36
    .end local v3    # "e":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<TK;TV;>;"
    .end local v4    # "oldValue":Ljava/lang/Object;, "TV;"
    .end local v6    # "oldKey":Ljava/lang/Object;, "TK;"
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 45
    .restart local v3    # "e":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<TK;TV;>;"
    .restart local v4    # "oldValue":Ljava/lang/Object;, "TV;"
    .restart local v6    # "oldKey":Ljava/lang/Object;, "TK;"
    :cond_0
    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v8

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-static {v7}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v9

    add-int/lit8 v9, v9, 0x1

    invoke-static {v8}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v10

    add-int/2addr v9, v10

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10, v9}, Ljava/lang/StringBuilder;-><init>(I)V

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    aget-object v7, p1, v2

    const-string v8, "value"

    invoke-static {v8, v5, v7}, Lcom/google/common/collect/JdkBackedImmutableBiMap;->conflictException(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/IllegalArgumentException;

    move-result-object v5

    throw v5

    .line 41
    .end local v6    # "oldKey":Ljava/lang/Object;, "TK;"
    :cond_1
    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v4}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-static {v6}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/String;->length()I

    move-result v8

    add-int/lit8 v8, v8, 0x1

    invoke-static {v7}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v9

    add-int/2addr v8, v9

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9, v8}, Ljava/lang/StringBuilder;-><init>(I)V

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    aget-object v6, p1, v2

    const-string v7, "key"

    invoke-static {v7, v5, v6}, Lcom/google/common/collect/JdkBackedImmutableBiMap;->conflictException(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/IllegalArgumentException;

    move-result-object v5

    throw v5

    .line 48
    .end local v2    # "i":I
    .end local v3    # "e":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<TK;TV;>;"
    .end local v4    # "oldValue":Ljava/lang/Object;, "TV;"
    :cond_2
    invoke-static {p1, p0}, Lcom/google/common/collect/ImmutableList;->asImmutableList([Ljava/lang/Object;I)Lcom/google/common/collect/ImmutableList;

    move-result-object v2

    .line 49
    .local v2, "entryList":Lcom/google/common/collect/ImmutableList;, "Lcom/google/common/collect/ImmutableList<Ljava/util/Map$Entry<TK;TV;>;>;"
    new-instance v3, Lcom/google/common/collect/JdkBackedImmutableBiMap;

    invoke-direct {v3, v2, v0, v1}, Lcom/google/common/collect/JdkBackedImmutableBiMap;-><init>(Lcom/google/common/collect/ImmutableList;Ljava/util/Map;Ljava/util/Map;)V

    return-object v3
.end method


# virtual methods
.method createEntrySet()Lcom/google/common/collect/ImmutableSet;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/common/collect/ImmutableSet<",
            "Ljava/util/Map$Entry<",
            "TK;TV;>;>;"
        }
    .end annotation

    .line 109
    .local p0, "this":Lcom/google/common/collect/JdkBackedImmutableBiMap;, "Lcom/google/common/collect/JdkBackedImmutableBiMap<TK;TV;>;"
    new-instance v0, Lcom/google/common/collect/ImmutableMapEntrySet$RegularEntrySet;

    iget-object v1, p0, Lcom/google/common/collect/JdkBackedImmutableBiMap;->entries:Lcom/google/common/collect/ImmutableList;

    invoke-direct {v0, p0, v1}, Lcom/google/common/collect/ImmutableMapEntrySet$RegularEntrySet;-><init>(Lcom/google/common/collect/ImmutableMap;Lcom/google/common/collect/ImmutableList;)V

    return-object v0
.end method

.method createKeySet()Lcom/google/common/collect/ImmutableSet;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/common/collect/ImmutableSet<",
            "TK;>;"
        }
    .end annotation

    .line 114
    .local p0, "this":Lcom/google/common/collect/JdkBackedImmutableBiMap;, "Lcom/google/common/collect/JdkBackedImmutableBiMap<TK;TV;>;"
    new-instance v0, Lcom/google/common/collect/ImmutableMapKeySet;

    invoke-direct {v0, p0}, Lcom/google/common/collect/ImmutableMapKeySet;-><init>(Lcom/google/common/collect/ImmutableMap;)V

    return-object v0
.end method

.method public get(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "key"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            ")TV;"
        }
    .end annotation

    .line 104
    .local p0, "this":Lcom/google/common/collect/JdkBackedImmutableBiMap;, "Lcom/google/common/collect/JdkBackedImmutableBiMap<TK;TV;>;"
    iget-object v0, p0, Lcom/google/common/collect/JdkBackedImmutableBiMap;->forwardDelegate:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic inverse()Lcom/google/common/collect/BiMap;
    .locals 1

    .line 30
    .local p0, "this":Lcom/google/common/collect/JdkBackedImmutableBiMap;, "Lcom/google/common/collect/JdkBackedImmutableBiMap<TK;TV;>;"
    invoke-virtual {p0}, Lcom/google/common/collect/JdkBackedImmutableBiMap;->inverse()Lcom/google/common/collect/ImmutableBiMap;

    move-result-object v0

    return-object v0
.end method

.method public inverse()Lcom/google/common/collect/ImmutableBiMap;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/common/collect/ImmutableBiMap<",
            "TV;TK;>;"
        }
    .end annotation

    .line 72
    .local p0, "this":Lcom/google/common/collect/JdkBackedImmutableBiMap;, "Lcom/google/common/collect/JdkBackedImmutableBiMap<TK;TV;>;"
    iget-object v0, p0, Lcom/google/common/collect/JdkBackedImmutableBiMap;->inverse:Lcom/google/common/collect/JdkBackedImmutableBiMap;

    .line 73
    .local v0, "result":Lcom/google/common/collect/JdkBackedImmutableBiMap;, "Lcom/google/common/collect/JdkBackedImmutableBiMap<TV;TK;>;"
    if-nez v0, :cond_0

    .line 74
    new-instance v1, Lcom/google/common/collect/JdkBackedImmutableBiMap;

    new-instance v2, Lcom/google/common/collect/JdkBackedImmutableBiMap$InverseEntries;

    const/4 v3, 0x0

    invoke-direct {v2, p0, v3}, Lcom/google/common/collect/JdkBackedImmutableBiMap$InverseEntries;-><init>(Lcom/google/common/collect/JdkBackedImmutableBiMap;Lcom/google/common/collect/JdkBackedImmutableBiMap$1;)V

    iget-object v3, p0, Lcom/google/common/collect/JdkBackedImmutableBiMap;->backwardDelegate:Ljava/util/Map;

    iget-object v4, p0, Lcom/google/common/collect/JdkBackedImmutableBiMap;->forwardDelegate:Ljava/util/Map;

    invoke-direct {v1, v2, v3, v4}, Lcom/google/common/collect/JdkBackedImmutableBiMap;-><init>(Lcom/google/common/collect/ImmutableList;Ljava/util/Map;Ljava/util/Map;)V

    move-object v0, v1

    iput-object v1, p0, Lcom/google/common/collect/JdkBackedImmutableBiMap;->inverse:Lcom/google/common/collect/JdkBackedImmutableBiMap;

    .line 78
    iput-object p0, v0, Lcom/google/common/collect/JdkBackedImmutableBiMap;->inverse:Lcom/google/common/collect/JdkBackedImmutableBiMap;

    .line 80
    :cond_0
    return-object v0
.end method

.method isPartialView()Z
    .locals 1

    .line 119
    .local p0, "this":Lcom/google/common/collect/JdkBackedImmutableBiMap;, "Lcom/google/common/collect/JdkBackedImmutableBiMap<TK;TV;>;"
    const/4 v0, 0x0

    return v0
.end method

.method public size()I
    .locals 1

    .line 65
    .local p0, "this":Lcom/google/common/collect/JdkBackedImmutableBiMap;, "Lcom/google/common/collect/JdkBackedImmutableBiMap<TK;TV;>;"
    iget-object v0, p0, Lcom/google/common/collect/JdkBackedImmutableBiMap;->entries:Lcom/google/common/collect/ImmutableList;

    invoke-virtual {v0}, Lcom/google/common/collect/ImmutableList;->size()I

    move-result v0

    return v0
.end method
