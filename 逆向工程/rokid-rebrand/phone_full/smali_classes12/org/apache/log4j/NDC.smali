.class public Lorg/apache/log4j/NDC;
.super Ljava/lang/Object;
.source "NDC.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/apache/log4j/NDC$DiagnosticContext;
    }
.end annotation


# static fields
.field static final REAP_THRESHOLD:I = 0x5

.field static ht:Ljava/util/Hashtable;

.field static pushCounter:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 114
    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    sput-object v0, Lorg/apache/log4j/NDC;->ht:Ljava/util/Hashtable;

    .line 116
    const/4 v0, 0x0

    sput v0, Lorg/apache/log4j/NDC;->pushCounter:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 127
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static clear()V
    .locals 2

    .line 153
    invoke-static {}, Lorg/apache/log4j/NDC;->getCurrentStack()Ljava/util/Stack;

    move-result-object v0

    .line 154
    .local v0, "stack":Ljava/util/Stack;
    if-eqz v0, :cond_0

    .line 155
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/Stack;->setSize(I)V

    .line 156
    :cond_0
    return-void
.end method

.method public static cloneStack()Ljava/util/Stack;
    .locals 2

    .line 176
    invoke-static {}, Lorg/apache/log4j/NDC;->getCurrentStack()Ljava/util/Stack;

    move-result-object v0

    .line 177
    .local v0, "stack":Ljava/util/Stack;
    if-nez v0, :cond_0

    .line 178
    const/4 v1, 0x0

    return-object v1

    .line 180
    :cond_0
    invoke-virtual {v0}, Ljava/util/Stack;->clone()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Stack;

    return-object v1
.end method

.method public static get()Ljava/lang/String;
    .locals 2

    .line 220
    invoke-static {}, Lorg/apache/log4j/NDC;->getCurrentStack()Ljava/util/Stack;

    move-result-object v0

    .line 221
    .local v0, "s":Ljava/util/Stack;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/util/Stack;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 222
    invoke-virtual {v0}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/apache/log4j/NDC$DiagnosticContext;

    iget-object v1, v1, Lorg/apache/log4j/NDC$DiagnosticContext;->fullMessage:Ljava/lang/String;

    return-object v1

    .line 224
    :cond_0
    const/4 v1, 0x0

    return-object v1
.end method

.method private static getCurrentStack()Ljava/util/Stack;
    .locals 2

    .line 134
    sget-object v0, Lorg/apache/log4j/NDC;->ht:Ljava/util/Hashtable;

    if-eqz v0, :cond_0

    .line 135
    sget-object v0, Lorg/apache/log4j/NDC;->ht:Ljava/util/Hashtable;

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Stack;

    return-object v0

    .line 137
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static getDepth()I
    .locals 2

    .line 236
    invoke-static {}, Lorg/apache/log4j/NDC;->getCurrentStack()Ljava/util/Stack;

    move-result-object v0

    .line 237
    .local v0, "stack":Ljava/util/Stack;
    if-nez v0, :cond_0

    .line 238
    const/4 v1, 0x0

    return v1

    .line 240
    :cond_0
    invoke-virtual {v0}, Ljava/util/Stack;->size()I

    move-result v1

    return v1
.end method

.method public static inherit(Ljava/util/Stack;)V
    .locals 2
    .param p0, "stack"    # Ljava/util/Stack;

    .line 208
    if-eqz p0, :cond_0

    .line 209
    sget-object v0, Lorg/apache/log4j/NDC;->ht:Ljava/util/Hashtable;

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {v0, v1, p0}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 210
    :cond_0
    return-void
.end method

.method private static lazyRemove()V
    .locals 6

    .line 246
    sget-object v0, Lorg/apache/log4j/NDC;->ht:Ljava/util/Hashtable;

    if-nez v0, :cond_0

    return-void

    .line 253
    :cond_0
    sget-object v0, Lorg/apache/log4j/NDC;->ht:Ljava/util/Hashtable;

    monitor-enter v0

    .line 255
    const/4 v1, 0x0

    :try_start_0
    sget v2, Lorg/apache/log4j/NDC;->pushCounter:I

    add-int/lit8 v2, v2, 0x1

    sput v2, Lorg/apache/log4j/NDC;->pushCounter:I

    const/4 v3, 0x5

    if-gt v2, v3, :cond_1

    .line 256
    monitor-exit v0

    return-void

    .line 258
    :cond_1
    const/4 v2, 0x0

    sput v2, Lorg/apache/log4j/NDC;->pushCounter:I

    .line 261
    const/4 v2, 0x0

    .line 262
    .local v2, "misses":I
    new-instance v3, Ljava/util/Vector;

    invoke-direct {v3}, Ljava/util/Vector;-><init>()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v1, v3

    .line 263
    .local v1, "v":Ljava/util/Vector;
    :try_start_1
    sget-object v3, Lorg/apache/log4j/NDC;->ht:Ljava/util/Hashtable;

    invoke-virtual {v3}, Ljava/util/Hashtable;->keys()Ljava/util/Enumeration;

    move-result-object v3

    .line 268
    .local v3, "enumeration":Ljava/util/Enumeration;
    :goto_0
    invoke-interface {v3}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v4

    if-eqz v4, :cond_3

    const/4 v4, 0x4

    if-gt v2, v4, :cond_3

    .line 269
    invoke-interface {v3}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Thread;

    .line 270
    .local v4, "t":Ljava/lang/Thread;
    invoke-virtual {v4}, Ljava/lang/Thread;->isAlive()Z

    move-result v5

    if-eqz v5, :cond_2

    .line 271
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 273
    :cond_2
    const/4 v2, 0x0

    .line 274
    invoke-virtual {v1, v4}, Ljava/util/Vector;->addElement(Ljava/lang/Object;)V

    .line 276
    .end local v4    # "t":Ljava/lang/Thread;
    :goto_1
    goto :goto_0

    .line 277
    .end local v2    # "misses":I
    .end local v3    # "enumeration":Ljava/util/Enumeration;
    :cond_3
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 279
    invoke-virtual {v1}, Ljava/util/Vector;->size()I

    move-result v0

    .line 280
    .local v0, "size":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_2
    if-ge v2, v0, :cond_4

    .line 281
    invoke-virtual {v1, v2}, Ljava/util/Vector;->elementAt(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Thread;

    .line 282
    .local v3, "t":Ljava/lang/Thread;
    new-instance v4, Ljava/lang/StringBuffer;

    invoke-direct {v4}, Ljava/lang/StringBuffer;-><init>()V

    const-string v5, "Lazy NDC removal for thread ["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v4

    invoke-virtual {v3}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v4

    const-string v5, "] ("

    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v4

    sget-object v5, Lorg/apache/log4j/NDC;->ht:Ljava/util/Hashtable;

    invoke-virtual {v5}, Ljava/util/Hashtable;->size()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    move-result-object v4

    const-string v5, ")."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lorg/apache/log4j/helpers/LogLog;->debug(Ljava/lang/String;)V

    .line 284
    sget-object v4, Lorg/apache/log4j/NDC;->ht:Ljava/util/Hashtable;

    invoke-virtual {v4, v3}, Ljava/util/Hashtable;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 280
    .end local v3    # "t":Ljava/lang/Thread;
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 286
    .end local v2    # "i":I
    :cond_4
    return-void

    .line 277
    .end local v0    # "size":I
    .end local v1    # "v":Ljava/util/Vector;
    :catchall_0
    move-exception v2

    .restart local v1    # "v":Ljava/util/Vector;
    :goto_3
    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw v2

    :catchall_1
    move-exception v2

    goto :goto_3
.end method

.method public static peek()Ljava/lang/String;
    .locals 2

    .line 321
    invoke-static {}, Lorg/apache/log4j/NDC;->getCurrentStack()Ljava/util/Stack;

    move-result-object v0

    .line 322
    .local v0, "stack":Ljava/util/Stack;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/util/Stack;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 323
    invoke-virtual {v0}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/apache/log4j/NDC$DiagnosticContext;

    iget-object v1, v1, Lorg/apache/log4j/NDC$DiagnosticContext;->message:Ljava/lang/String;

    return-object v1

    .line 325
    :cond_0
    const-string v1, ""

    return-object v1
.end method

.method public static pop()Ljava/lang/String;
    .locals 2

    .line 301
    invoke-static {}, Lorg/apache/log4j/NDC;->getCurrentStack()Ljava/util/Stack;

    move-result-object v0

    .line 302
    .local v0, "stack":Ljava/util/Stack;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/util/Stack;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 303
    invoke-virtual {v0}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/apache/log4j/NDC$DiagnosticContext;

    iget-object v1, v1, Lorg/apache/log4j/NDC$DiagnosticContext;->message:Ljava/lang/String;

    return-object v1

    .line 305
    :cond_0
    const-string v1, ""

    return-object v1
.end method

.method public static push(Ljava/lang/String;)V
    .locals 4
    .param p0, "message"    # Ljava/lang/String;

    .line 338
    invoke-static {}, Lorg/apache/log4j/NDC;->getCurrentStack()Ljava/util/Stack;

    move-result-object v0

    .line 340
    .local v0, "stack":Ljava/util/Stack;
    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 341
    new-instance v2, Lorg/apache/log4j/NDC$DiagnosticContext;

    invoke-direct {v2, p0, v1}, Lorg/apache/log4j/NDC$DiagnosticContext;-><init>(Ljava/lang/String;Lorg/apache/log4j/NDC$DiagnosticContext;)V

    move-object v1, v2

    .line 342
    .local v1, "dc":Lorg/apache/log4j/NDC$DiagnosticContext;
    new-instance v2, Ljava/util/Stack;

    invoke-direct {v2}, Ljava/util/Stack;-><init>()V

    move-object v0, v2

    .line 343
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v2

    .line 344
    .local v2, "key":Ljava/lang/Thread;
    sget-object v3, Lorg/apache/log4j/NDC;->ht:Ljava/util/Hashtable;

    invoke-virtual {v3, v2, v0}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 345
    invoke-virtual {v0, v1}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    .line 346
    .end local v1    # "dc":Lorg/apache/log4j/NDC$DiagnosticContext;
    .end local v2    # "key":Ljava/lang/Thread;
    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Ljava/util/Stack;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 347
    new-instance v2, Lorg/apache/log4j/NDC$DiagnosticContext;

    invoke-direct {v2, p0, v1}, Lorg/apache/log4j/NDC$DiagnosticContext;-><init>(Ljava/lang/String;Lorg/apache/log4j/NDC$DiagnosticContext;)V

    move-object v1, v2

    .line 348
    .restart local v1    # "dc":Lorg/apache/log4j/NDC$DiagnosticContext;
    invoke-virtual {v0, v1}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    .line 349
    .end local v1    # "dc":Lorg/apache/log4j/NDC$DiagnosticContext;
    goto :goto_0

    .line 350
    :cond_1
    invoke-virtual {v0}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/apache/log4j/NDC$DiagnosticContext;

    .line 351
    .local v1, "parent":Lorg/apache/log4j/NDC$DiagnosticContext;
    new-instance v2, Lorg/apache/log4j/NDC$DiagnosticContext;

    invoke-direct {v2, p0, v1}, Lorg/apache/log4j/NDC$DiagnosticContext;-><init>(Ljava/lang/String;Lorg/apache/log4j/NDC$DiagnosticContext;)V

    invoke-virtual {v0, v2}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    .line 353
    .end local v1    # "parent":Lorg/apache/log4j/NDC$DiagnosticContext;
    :goto_0
    return-void
.end method

.method public static remove()V
    .locals 2

    .line 377
    sget-object v0, Lorg/apache/log4j/NDC;->ht:Ljava/util/Hashtable;

    if-eqz v0, :cond_0

    .line 378
    sget-object v0, Lorg/apache/log4j/NDC;->ht:Ljava/util/Hashtable;

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Hashtable;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 381
    invoke-static {}, Lorg/apache/log4j/NDC;->lazyRemove()V

    .line 383
    :cond_0
    return-void
.end method

.method public static setMaxDepth(I)V
    .locals 2
    .param p0, "maxDepth"    # I

    .line 415
    invoke-static {}, Lorg/apache/log4j/NDC;->getCurrentStack()Ljava/util/Stack;

    move-result-object v0

    .line 416
    .local v0, "stack":Ljava/util/Stack;
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/util/Stack;->size()I

    move-result v1

    if-ge p0, v1, :cond_0

    .line 417
    invoke-virtual {v0, p0}, Ljava/util/Stack;->setSize(I)V

    .line 418
    :cond_0
    return-void
.end method
