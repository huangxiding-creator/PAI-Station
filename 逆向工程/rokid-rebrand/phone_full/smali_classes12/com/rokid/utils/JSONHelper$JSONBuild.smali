.class public Lcom/rokid/utils/JSONHelper$JSONBuild;
.super Ljava/lang/Object;
.source "JSONHelper.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/utils/JSONHelper;
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

    .line 454
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 455
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/rokid/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    .line 456
    return-void
.end method

.method synthetic constructor <init>(Lcom/rokid/utils/JSONHelper$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/rokid/utils/JSONHelper$1;

    .line 450
    invoke-direct {p0}, Lcom/rokid/utils/JSONHelper$JSONBuild;-><init>()V

    return-void
.end method


# virtual methods
.method public build()Ljava/lang/String;
    .locals 1

    .line 499
    iget-object v0, p0, Lcom/rokid/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-static {v0}, Lcom/rokid/utils/JSONHelper;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public put(Ljava/lang/String;C)Lcom/rokid/utils/JSONHelper$JSONBuild;
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # C

    .line 469
    iget-object v0, p0, Lcom/rokid/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-static {p2}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 470
    return-object p0
.end method

.method public put(Ljava/lang/String;I)Lcom/rokid/utils/JSONHelper$JSONBuild;
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # I

    .line 474
    iget-object v0, p0, Lcom/rokid/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 475
    return-object p0
.end method

.method public put(Ljava/lang/String;J)Lcom/rokid/utils/JSONHelper$JSONBuild;
    .locals 2
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # J

    .line 484
    iget-object v0, p0, Lcom/rokid/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-interface {v0, p1, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 485
    return-object p0
.end method

.method public put(Ljava/lang/String;Ljava/lang/CharSequence;)Lcom/rokid/utils/JSONHelper$JSONBuild;
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/CharSequence;

    .line 464
    iget-object v0, p0, Lcom/rokid/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 465
    return-object p0
.end method

.method public put(Ljava/lang/String;Ljava/lang/Integer;)Lcom/rokid/utils/JSONHelper$JSONBuild;
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Integer;

    .line 479
    iget-object v0, p0, Lcom/rokid/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 480
    return-object p0
.end method

.method public put(Ljava/lang/String;Ljava/lang/Long;)Lcom/rokid/utils/JSONHelper$JSONBuild;
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Long;

    .line 489
    iget-object v0, p0, Lcom/rokid/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 490
    return-object p0
.end method

.method public put(Ljava/lang/String;Ljava/lang/Object;)Lcom/rokid/utils/JSONHelper$JSONBuild;
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/Object;

    .line 494
    iget-object v0, p0, Lcom/rokid/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 495
    return-object p0
.end method

.method public put(Ljava/lang/String;Ljava/lang/String;)Lcom/rokid/utils/JSONHelper$JSONBuild;
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .line 459
    iget-object v0, p0, Lcom/rokid/utils/JSONHelper$JSONBuild;->map:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 460
    return-object p0
.end method
