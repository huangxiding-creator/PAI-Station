.class final Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;
.super Ljava/lang/Object;
.source "CollectCollectors.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/common/collect/CollectCollectors;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "EnumSetAccumulator"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<E:",
        "Ljava/lang/Enum<",
        "TE;>;>",
        "Ljava/lang/Object;"
    }
.end annotation


# static fields
.field static final TO_IMMUTABLE_ENUM_SET:Ljava/util/stream/Collector;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/stream/Collector<",
            "Ljava/lang/Enum<",
            "*>;*",
            "Lcom/google/common/collect/ImmutableSet<",
            "+",
            "Ljava/lang/Enum<",
            "*>;>;>;"
        }
    .end annotation
.end field


# instance fields
.field private set:Ljava/util/EnumSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/EnumSet<",
            "TE;>;"
        }
    .end annotation
.end field


# direct methods
.method public static synthetic $r8$lambda$XEOS3SBVkrJzmN-eR6tLspDQTgs()Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;
    .locals 1

    new-instance v0, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;

    invoke-direct {v0}, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;-><init>()V

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 7

    .line 98
    new-instance v0, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator$$ExternalSyntheticLambda0;-><init>()V

    new-instance v1, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator$$ExternalSyntheticLambda1;

    invoke-direct {v1}, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator$$ExternalSyntheticLambda1;-><init>()V

    new-instance v2, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator$$ExternalSyntheticLambda2;

    invoke-direct {v2}, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator$$ExternalSyntheticLambda2;-><init>()V

    new-instance v3, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator$$ExternalSyntheticLambda3;

    invoke-direct {v3}, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator$$ExternalSyntheticLambda3;-><init>()V

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/util/stream/Collector$Characteristics;

    const/4 v5, 0x0

    sget-object v6, Ljava/util/stream/Collector$Characteristics;->UNORDERED:Ljava/util/stream/Collector$Characteristics;

    aput-object v6, v4, v5

    .line 100
    invoke-static {v0, v1, v2, v3, v4}, Ljava/util/stream/Collector;->of(Ljava/util/function/Supplier;Ljava/util/function/BiConsumer;Ljava/util/function/BinaryOperator;Ljava/util/function/Function;[Ljava/util/stream/Collector$Characteristics;)Ljava/util/stream/Collector;

    move-result-object v0

    sput-object v0, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;->TO_IMMUTABLE_ENUM_SET:Ljava/util/stream/Collector;

    .line 98
    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 96
    .local p0, "this":Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;, "Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator<TE;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method add(Ljava/lang/Enum;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TE;)V"
        }
    .end annotation

    .line 110
    .local p0, "this":Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;, "Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator<TE;>;"
    .local p1, "e":Ljava/lang/Enum;, "TE;"
    iget-object v0, p0, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;->set:Ljava/util/EnumSet;

    if-nez v0, :cond_0

    .line 111
    invoke-static {p1}, Ljava/util/EnumSet;->of(Ljava/lang/Enum;)Ljava/util/EnumSet;

    move-result-object v0

    iput-object v0, p0, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;->set:Ljava/util/EnumSet;

    goto :goto_0

    .line 113
    :cond_0
    iget-object v0, p0, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;->set:Ljava/util/EnumSet;

    invoke-virtual {v0, p1}, Ljava/util/EnumSet;->add(Ljava/lang/Object;)Z

    .line 115
    :goto_0
    return-void
.end method

.method combine(Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;)Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator<",
            "TE;>;)",
            "Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator<",
            "TE;>;"
        }
    .end annotation

    .line 118
    .local p0, "this":Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;, "Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator<TE;>;"
    .local p1, "other":Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;, "Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator<TE;>;"
    iget-object v0, p0, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;->set:Ljava/util/EnumSet;

    if-nez v0, :cond_0

    .line 119
    return-object p1

    .line 120
    :cond_0
    iget-object v0, p1, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;->set:Ljava/util/EnumSet;

    if-nez v0, :cond_1

    .line 121
    return-object p0

    .line 123
    :cond_1
    iget-object v0, p0, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;->set:Ljava/util/EnumSet;

    iget-object v1, p1, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;->set:Ljava/util/EnumSet;

    invoke-virtual {v0, v1}, Ljava/util/EnumSet;->addAll(Ljava/util/Collection;)Z

    .line 124
    return-object p0
.end method

.method toImmutableSet()Lcom/google/common/collect/ImmutableSet;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/google/common/collect/ImmutableSet<",
            "TE;>;"
        }
    .end annotation

    .line 129
    .local p0, "this":Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;, "Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator<TE;>;"
    iget-object v0, p0, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;->set:Ljava/util/EnumSet;

    if-nez v0, :cond_0

    invoke-static {}, Lcom/google/common/collect/ImmutableSet;->of()Lcom/google/common/collect/ImmutableSet;

    move-result-object v0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/google/common/collect/CollectCollectors$EnumSetAccumulator;->set:Ljava/util/EnumSet;

    invoke-static {v0}, Lcom/google/common/collect/ImmutableEnumSet;->asImmutable(Ljava/util/EnumSet;)Lcom/google/common/collect/ImmutableSet;

    move-result-object v0

    :goto_0
    return-object v0
.end method
