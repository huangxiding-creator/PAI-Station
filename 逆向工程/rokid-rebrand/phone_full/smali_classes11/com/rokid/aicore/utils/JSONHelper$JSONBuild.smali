.class public Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/aicore/utils/JSONHelper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "JSONBuild"
.end annotation


# instance fields
.field private map:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    return-void
.end method

.method public synthetic constructor <init>(Lcom/rokid/aicore/utils/JSONHelper$1;)V
    .locals 0

    invoke-direct {p0}, Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;-><init>()V

    return-void
.end method


# virtual methods
.method public build()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-static {v0}, Lcom/rokid/aicore/utils/JSONHelper;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public put(Ljava/lang/String;C)Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-static {p2}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object p2

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method

.method public put(Ljava/lang/String;I)Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method

.method public put(Ljava/lang/String;J)Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method

.method public put(Ljava/lang/String;Ljava/lang/CharSequence;)Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method

.method public put(Ljava/lang/String;Ljava/lang/Integer;)Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method

.method public put(Ljava/lang/String;Ljava/lang/Long;)Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method

.method public put(Ljava/lang/String;Ljava/lang/Object;)Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method

.method public put(Ljava/lang/String;Ljava/lang/String;)Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;
    .locals 1

    iget-object v0, p0, Lcom/rokid/aicore/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method
