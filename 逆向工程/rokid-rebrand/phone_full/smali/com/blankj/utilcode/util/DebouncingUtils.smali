.class public Lcom/blankj/utilcode/util/DebouncingUtils;
.super Ljava/lang/Object;
.source "DebouncingUtils.java"


# static fields
.field private static final CACHE_SIZE:I = 0x40

.field private static final DEBOUNCING_DEFAULT_VALUE:J = 0x3e8L

.field private static final KEY_MILLIS_MAP:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 24
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    const/16 v1, 0x40

    invoke-direct {v0, v1}, Ljava/util/concurrent/ConcurrentHashMap;-><init>(I)V

    sput-object v0, Lcom/blankj/utilcode/util/DebouncingUtils;->KEY_MILLIS_MAP:Ljava/util/Map;

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string/jumbo v1, "u can\'t instantiate me..."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static clearIfNecessary(J)V
    .locals 5
    .param p0, "curTime"    # J

    .line 77
    sget-object v0, Lcom/blankj/utilcode/util/DebouncingUtils;->KEY_MILLIS_MAP:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->size()I

    move-result v0

    const/16 v1, 0x40

    if-ge v0, v1, :cond_0

    return-void

    .line 78
    :cond_0
    sget-object v0, Lcom/blankj/utilcode/util/DebouncingUtils;->KEY_MILLIS_MAP:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .local v0, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/Long;>;>;"
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 79
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 80
    .local v1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/Long;>;"
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Long;

    .line 81
    .local v2, "validTime":Ljava/lang/Long;
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    cmp-long v3, p0, v3

    if-ltz v3, :cond_1

    .line 82
    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    .line 84
    .end local v1    # "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/Long;>;"
    .end local v2    # "validTime":Ljava/lang/Long;
    :cond_1
    goto :goto_0

    .line 85
    .end local v0    # "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/util/Map$Entry<Ljava/lang/String;Ljava/lang/Long;>;>;"
    :cond_2
    return-void
.end method

.method public static isValid(Landroid/view/View;)Z
    .locals 2
    .param p0, "view"    # Landroid/view/View;

    .line 38
    const-wide/16 v0, 0x3e8

    invoke-static {p0, v0, v1}, Lcom/blankj/utilcode/util/DebouncingUtils;->isValid(Landroid/view/View;J)Z

    move-result v0

    return v0
.end method

.method public static isValid(Landroid/view/View;J)Z
    .locals 1
    .param p0, "view"    # Landroid/view/View;
    .param p1, "duration"    # J

    .line 49
    invoke-virtual {p0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1, p2}, Lcom/blankj/utilcode/util/DebouncingUtils;->isValid(Ljava/lang/String;J)Z

    move-result v0

    return v0
.end method

.method public static isValid(Ljava/lang/String;J)Z
    .locals 6
    .param p0, "key"    # Ljava/lang/String;
    .param p1, "duration"    # J

    .line 60
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 63
    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-ltz v0, :cond_2

    .line 66
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 67
    .local v0, "curTime":J
    invoke-static {v0, v1}, Lcom/blankj/utilcode/util/DebouncingUtils;->clearIfNecessary(J)V

    .line 68
    sget-object v2, Lcom/blankj/utilcode/util/DebouncingUtils;->KEY_MILLIS_MAP:Ljava/util/Map;

    invoke-interface {v2, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Long;

    .line 69
    .local v2, "validTime":Ljava/lang/Long;
    if-eqz v2, :cond_1

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    cmp-long v3, v0, v3

    if-ltz v3, :cond_0

    goto :goto_0

    .line 73
    :cond_0
    const/4 v3, 0x0

    return v3

    .line 70
    :cond_1
    :goto_0
    sget-object v3, Lcom/blankj/utilcode/util/DebouncingUtils;->KEY_MILLIS_MAP:Ljava/util/Map;

    add-long v4, v0, p1

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    invoke-interface {v3, p0, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 71
    const/4 v3, 0x1

    return v3

    .line 64
    .end local v0    # "curTime":J
    .end local v2    # "validTime":Ljava/lang/Long;
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The duration is less than 0."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 61
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "The key is null."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
